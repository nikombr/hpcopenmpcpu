clear; close all; clc;

% Mlup N*N*N*iter*10^(-6)
% Mflop Mlups*(floating point opration), floating point opration = 11? 

N = 495

figure('Renderer', 'painters', 'Position', [400 400 1000 500]);
t = tiledlayout(1,2,'TileSpacing','compact');

nexttile;
file = sprintf("../code/results/par_bas_j_static_old.%d.txt",N);
data = readmatrix(file);
iter = data(1,3);
threads = data(:,1);
runtime = data(:,5);
speedup = runtime(1)./runtime;
Mlups = N*N*N*10^(-6)*iter./runtime;
Mflops = Mlups*11;

plot(threads,speedup,'.-','MarkerSize',10)
hold on
grid on
file = sprintf("../code/results/no_opt_par_bas_j_%d.txt",N);
data = readmatrix(file);
iter = data(1,3);
threads = data(:,1);
runtime = data(:,5);
speedup = runtime(1)./runtime;
Mlups = N*N*N*10^(-6)*iter./runtime;
Mflops = Mlups*11;

plot(threads,speedup,'.-','MarkerSize',10)


xlabel('Number of threads','Interpreter','latex','FontSize',15);

ylabel('Speed-up','Interpreter','latex','FontSize',15);

ylim([0,22])
xlim([0,25])

nexttile;
file = sprintf("../code/results/par_bas_j_static_old.%d.txt",N);
data = readmatrix(file);
iter = data(1,3);
threads = data(:,1);
runtime = data(:,5);
speedup = runtime(1)./runtime;
Mlups = N*N*N*10^(-6)*iter./runtime;
Mflops = Mlups*11;

plot(threads,runtime,'.-','MarkerSize',10)
hold on
grid on
file = sprintf("../code/results/no_opt_par_bas_j_%d.txt",N);
data = readmatrix(file);
iter = data(1,3);
threads = data(:,1);
runtime = data(:,5);
speedup = runtime(1)./runtime;
Mlups = N*N*N*10^(-6)*iter./runtime;
Mflops = Mlups*11;

plot(threads,runtime,'.-','MarkerSize',10)




xlabel('Number of threads','Interpreter','latex','FontSize',15);

ylabel('Execution time','Interpreter','latex','FontSize',15);

%ylim([0,22])
xlim([0,25])


lgd = legend('No Optimizer','\texttt{-O3}','Interpreter','latex','FontSize',15,'numcolumns',4)
lgd.Layout.Tile = 'south';

sgtitle("$\textbf{Jacobi}$","fontsize",18,'interpreter','latex')

exportgraphics(gcf,'optimizer_test.png','Resolution',300);