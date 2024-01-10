
clear; close all; clc;

model = createpde();

%specifyCoefficients(model,"m",0,"d",0,"c",1,"a",0,"f",1);


gm = multicuboid(2,2,2,"ZOffset",-1);
model.Geometry = gm;

applyBoundaryCondition(model,"dirichlet","Edge",1:12,"u",@bound);
applyBoundaryCondition(model,"dirichlet","Face",1:6,"u",@bound);

figure
pdegplot(model,"CellLabels","on","FaceAlpha",0.5)


specifyCoefficients(model,"m",0,"d",0,"c",1,"a",0,"f",@fc);
m3 = generateMesh(model,"GeometricOrder","quadratic","Hmax",0.1);
results = solvepde(model);
u = results.NodalSolution;
figure;
subplot(1,2,1)
pdeplot3D(m3)
subplot(1,2,2)
pdeplot3D(model,"ColorMapData",u)

N = 55;

xq = linspace(-1,1,N+2);
[X,Y,Z] = meshgrid(xq,xq,xq);


uintrp = interpolateSolution(results,X,Y,Z);

uintrp = reshape(uintrp,[N+2,N+2,N+2]);

sol = cell(N+2,1);


X = linspace(-1,1,N+2);

if N == 5
    is = [2,round((N+1)/2),N+1];
else
    is = [2,round((N+1)/6),round((N+1)/4),round((N+1)/3),round((N+1)/2),round((N+1)/3*2),round((N+1)/4*3),round((N+1)/6*5),N+1];
end

for i=1:(N+2)
    sol{i} = reshape(uintrp(:,i,:),[N+2,N+2]);
end

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 820 700]);
for i=1:length(is)
    subplot(3,3,i)
    imagesc(X,X,sol{is(i)})
    axis equal
    axis tight
    title(sprintf('$i = %d, x=%.3f$',is(i),is(i)*delta-1),'Interpreter','latex','FontSize',16)
    ylabel('$y$','Interpreter','latex','FontSize',16)
    xlabel('$z$','Interpreter','latex','FontSize',16)
    ax = gca;
    ax.CLim = [0 20];
    colorbar
end

sgtitle("$\textbf{MATLAB Solver}$","fontsize",18,'interpreter','latex')

exportgraphics(gcf,sprintf('plotting/matlab_solution_x_%d.png',N),'Resolution',300);

for i=1:(N+2)
    sol{i} = reshape(uintrp(i,:,:),[N+2,N+2]);
end

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 820 700]);
for i=1:length(is)
    subplot(3,3,i)
    imagesc(X,X,sol{is(i)})
    axis equal
    axis tight
    title(sprintf('$j = %d, y=%.3f$',is(i),is(i)*delta-1),'Interpreter','latex','FontSize',16)
    ylabel('$x$','Interpreter','latex','FontSize',16)
    xlabel('$z$','Interpreter','latex','FontSize',16)
    ax = gca;
    ax.CLim = [0 20];
    colorbar
end

sgtitle("$\textbf{MATLAB Solver}$","fontsize",18,'interpreter','latex')

exportgraphics(gcf,sprintf('plotting/matlab_solution_y_%d.png',N),'Resolution',300);

for i=1:(N+2)
    sol{i} = reshape(uintrp(:,:,i),[N+2,N+2]);
end

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 820 700]);
for i=1:length(is)
    subplot(3,3,i)
    imagesc(X,X,sol{is(i)})
    axis equal
    axis tight
    title(sprintf('$k = %d, z=%.3f$',is(i),is(i)*delta-1),'Interpreter','latex','FontSize',16)
    ylabel('$y$','Interpreter','latex','FontSize',16)
    xlabel('$x$','Interpreter','latex','FontSize',16)
    ax = gca;
    ax.CLim = [0 20];
    colorbar
end

sgtitle("$\textbf{MATLAB Solver}$","fontsize",18,'interpreter','latex')

exportgraphics(gcf,sprintf('plotting/matlab_solution_z_%d.png',N),'Resolution',300);