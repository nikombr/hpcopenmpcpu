
%% Plot results

clear; close all; clc;

N = 55;

file = "../code/results/output.txt";

matrix = readmatrix(file);

data = cell(N+2,1);

for i=1:(N+2)
    data{i} = matrix(((i-1)*(N+2)+1):(i*(N+2)),:);
end


X = linspace(-1,1,N+2);

figure;
subplot(1,3,1)
imagesc(X,X,data{2})
axis equal
axis tight
title(sprintf('$i = %d$',1),'Interpreter','latex','FontSize',16)
ylabel('$y$','Interpreter','latex','FontSize',16)
xlabel('$z$','Interpreter','latex','FontSize',16)
subplot(1,3,2)
imagesc(X,X,data{round((N+1)/2)})
axis equal
axis tight
title(sprintf('$i = %d$',round((N+1)/2)),'Interpreter','latex','FontSize',16)
ylabel('$y$','Interpreter','latex','FontSize',16)
xlabel('$z$','Interpreter','latex','FontSize',16)
subplot(1,3,3)
imagesc(X,X,data{N+1})
axis equal
axis tight
title(sprintf('$i = %d$',N),'Interpreter','latex','FontSize',16)
ylabel('$y$','Interpreter','latex','FontSize',16)
xlabel('$z$','Interpreter','latex','FontSize',16)


exportgraphics(gcf,sprintf('solution_%d.png',N),'Resolution',300);