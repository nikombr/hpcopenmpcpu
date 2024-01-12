
%% Plot results x

clear; close all; clc;

N = 55;

file = "../code/results/output_x.txt";

matrix = readmatrix(file);

data = cell(N+2,1);

for i=1:(N+2)
    data{i} = matrix(((i-1)*(N+2)+1):(i*(N+2)),:);
end


X = linspace(-1,1,N+2);

is = [2,round((N+2)/6),floor((N+1)/4)+1,round((N+1)/3),floor((N+1)/2)+1,round((N+1)/3*2)+2,floor((N+1)/4*3)+1,round((N+1)/6*5)+1,N+1];

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 750 700]);
t = tiledlayout(3,3,'TileSpacing','compact');
for i=1:length(is)
    nexttile;
    imagesc(X,X,data{is(i)})
    axis equal
    axis tight
    title(sprintf('$i = %d, x=%.3f$',is(i)-1,(is(i)-1)*delta-1),'Interpreter','latex','FontSize',16)
    if i==1 | i==4 | i==7
        ylabel('$y$','Interpreter','latex','FontSize',16)
    end
    if i >6
        xlabel('$z$','Interpreter','latex','FontSize',16)
    end
    ax = gca;
    ax.CLim = [0 20];
end

cl = colorbar
cl.Layout.Tile = 'east';

sgtitle("$\textbf{C Implementation}$","fontsize",18,'interpreter','latex')


exportgraphics(gcf,sprintf('solution_x_%d.png',N),'Resolution',300);


%% Plot results y

clear; close all; clc;

N = 55;

file = "../code/results/output_y.txt";

matrix = readmatrix(file);

data = cell(N+2,1);

for i=1:(N+2)
    data{i} = matrix(((i-1)*(N+2)+1):(i*(N+2)),:);
end


X = linspace(-1,1,N+2);

is = [2,round((N+2)/6),floor((N+1)/4)+1,round((N+1)/3),floor((N+1)/2)+1,round((N+1)/3*2)+2,floor((N+1)/4*3)+1,round((N+1)/6*5)+1,N+1];

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 750 700]);
t = tiledlayout(3,3,'TileSpacing','compact');
for i=1:length(is)
    nexttile;
    imagesc(X,X,data{is(i)})
    axis equal
    axis tight
    title(sprintf('$j = %d, y=%.3f$',is(i)-1,(is(i)-1)*delta-1),'Interpreter','latex','FontSize',16)
    if i==1 | i==4 | i==7
        ylabel('$x$','Interpreter','latex','FontSize',16)
    end
    if i >6
        xlabel('$z$','Interpreter','latex','FontSize',16)
    end

    ax = gca;
    ax.CLim = [0 20];
end

cl = colorbar
cl.Layout.Tile = 'east';

sgtitle("$\textbf{C Implementation}$","fontsize",18,'interpreter','latex')


exportgraphics(gcf,sprintf('solution_y_%d.png',N),'Resolution',300);

%% Plot results z

clear; close all; clc;

N = 55;

file = "../code/results/output_z.txt";

matrix = readmatrix(file);

data = cell(N+2,1);

for i=1:(N+2)
    data{i} = matrix(((i-1)*(N+2)+1):(i*(N+2)),:);
end


X = linspace(-1,1,N+2);

is = [2,round((N+2)/6),floor((N+1)/4)+1,round((N+1)/3),floor((N+1)/2)+1,round((N+1)/3*2)+2,floor((N+1)/4*3)+1,round((N+1)/6*5)+1,N+1];

delta = 2.0/(N+1);

figure('Renderer', 'painters', 'Position', [400 400 750 700]);
t = tiledlayout(3,3,'TileSpacing','compact');
for i=1:length(is)
    nexttile;
    imagesc(X,X,data{is(i)})
    axis equal
    axis tight
    title(sprintf('$k = %d, z=%.3f$',is(i)-1,(is(i)-1)*delta-1),'Interpreter','latex','FontSize',16)
    if i==1 | i==4 | i==7
        ylabel('$y$','Interpreter','latex','FontSize',16)
    end
    if i >6
        xlabel('$x$','Interpreter','latex','FontSize',16)
    end
    ax = gca;
    ax.CLim = [0 20];
    
end

cl = colorbar
cl.Layout.Tile = 'east';

sgtitle("$\textbf{C Implementation}$","fontsize",18,'interpreter','latex')


exportgraphics(gcf,sprintf('solution_z_%d.png',N),'Resolution',300);

