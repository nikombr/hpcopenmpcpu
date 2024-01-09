
clear; close all; clc;

model = createpde();

%specifyCoefficients(model,"m",0,"d",0,"c",1,"a",0,"f",1);


gm = multicuboid(2,2,2);
model.Geometry = gm;

applyBoundaryCondition(model,"dirichlet","Edge",1:12,"u",@bound);
applyBoundaryCondition(model,"dirichlet","Face",1:6,"u",@bound);

%pdegplot(model,"CellLabels","on","FaceAlpha",0.5)


specifyCoefficients(model,"m",0,"d",0,"c",1,"a",0,"f",@fc);
m3 = generateMesh(model,"GeometricOrder","linear","Hmax",1);
results = solvepde(model);
u = results.NodalSolution;
figure;
subplot(1,2,1)
pdeplot3D(m3)
subplot(1,2,2)
pdeplot3D(model,"ColorMapData",u)

model
