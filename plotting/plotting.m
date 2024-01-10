
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

if N == 5
    is = [2,round((N+1)/2),N+1];
else
    is = [2,round((N+1)/6),round((N+1)/4),round((N+1)/3),round((N+1)/2),round((N+1)/3*2),round((N+1)/4*3),round((N+1)/6*5),N+1];
end

figure('Renderer', 'painters', 'Position', [400 400 1200 1200]);
for i=1:length(is)
    subplot(3,3,i)
    imagesc(X,X,data{is(i)})
    axis equal
    axis tight
    title(sprintf('$i = %d$',is(i)),'Interpreter','latex','FontSize',16)
    ylabel('$y$','Interpreter','latex','FontSize',16)
    xlabel('$z$','Interpreter','latex','FontSize',16)
    colorbar
end


exportgraphics(gcf,sprintf('solution_%d.png',N),'Resolution',300);