
clear; close all; clc;

file = "../code/results/sequential_j.txt";
jacobi = readmatrix(file);
file = "../code/results/sequential_gs.txt";
gauss = readmatrix(file);

figure('Renderer', 'painters', 'Position', [400 400 1100 300]);
t = tiledlayout(1,3,'TileSpacing','compact');

nexttile
plot(jacobi(:,1),jacobi(:,2),'LineWidth',1.5)
hold on
plot(gauss(:,1),gauss(:,2),'LineWidth',1.5)
grid on

xlabel('$N$','Interpreter','latex','FontSize',13)
ylabel('Iterations','Interpreter','latex','FontSize',13)

nexttile
plot(jacobi(:,1),jacobi(:,4),'LineWidth',1.5)
hold on
plot(gauss(:,1),gauss(:,4),'LineWidth',1.5)

xlabel('$N$','Interpreter','latex','FontSize',13)
ylabel('Runtime (s)','Interpreter','latex','FontSize',13)
grid on

nexttile
plot(jacobi(:,4),jacobi(:,2),'LineWidth',1.5)
hold on
plot(gauss(:,4),gauss(:,2),'LineWidth',1.5)

ylabel('Iterations','Interpreter','latex','FontSize',13)
xlabel('Runtime (s)','Interpreter','latex','FontSize',13)
grid on

lgd = legend('Jacobi','Gauss-Seidel','Interpreter','latex','FontSize',13,'numcolumns',2)
lgd.Layout.Tile = 'south';

exportgraphics(gcf,'sequential.png','Resolution',300);



%%

figure('Renderer', 'painters', 'Position', [400 400 500 300]);
plot(jacobi(:,1),64*10^(-9)*jacobi(:,1).^3.*jacobi(:,2)./jacobi(:,4),'LineWidth',1.5)
hold on
plot(gauss(:,1),64*10^(-9)*jacobi(:,1).^3.*gauss(:,2)./gauss(:,4),'LineWidth',1.5)
grid on

xlabel('$N$','Interpreter','latex','FontSize',13)
ylabel('Mlup/s','Interpreter','latex','FontSize',13)

legend('Jacobi','Gauss-Seidel','Interpreter','latex','FontSize',13)


exportgraphics(gcf,'sequential_iterations_per_second.png','Resolution',300);