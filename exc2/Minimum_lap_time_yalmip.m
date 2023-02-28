%% Stint optimization
% Jorn van Kampen
% Eindhoven University of Technology
% Initialized: 1-4-2021
% Convex optimization framework that minimizes stint time

clear; close all; clc;
load('Data.mat');
ds=par.Distance(2)-par.Distance(1);

%% Optimize speed profile with obj fun in space domain
yalmip('clear');

opts=sdpsettings;
opts.solver='mosek';
opts.verbose=1;

%% Scaling
    s.E_k = 1;
    s.v= 1;
    s.dt=1;
    s.F_p=1;
    s.F_drag=1;
    s.F_brk=1;

% Generate the optimization problem
tic;
[objective,variables,constraints] = OCP(par.Distance,ds,par,s); % convex
t_parse=toc

tic;
diagnostics=optimize(constraints,objective,opts);
t_solve=toc

%% Extract solution
sol.E_k = value(variables.E_k)*s.E_k;
sol.v = value(variables.v)*s.v;
sol.dt = value(variables.dt)*s.dt;
sol.F_drag = value(variables.F_drag)*s.F_drag;
sol.F_brk = value(variables.F_brk)*s.F_brk;
sol.F_p = value(variables.F_p)*s.F_p;

% Calculate lap time based on average velocity between two points
T_stint = [0 cumsum(2./(1./sol.dt(1:end-1)+1./(sol.dt(2:end))))]; % using dt
Tlap = diff([0 T_stint(end)])';

%% Plot
figure;
subplot(5,1,1:3)
colormap jet
plot(par.zandvoort(1,:),par.zandvoort(2,:),"color",[0.7,0.7,0.7],"LineWidth",6)
hold on
surface([par.zandvoort(1,:);par.zandvoort(1,:)],[par.zandvoort(2,:);par.zandvoort(2,:)],zeros(2,size(par.Distance,2)),[sol.v;sol.v]*3.6,...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
cbar = colorbar;
caxis(sqrt([min(par.E_max),max(par.E_max)]*2/par.m)*3.6)
cbar.Label.String = 'Velocity [km/h]';
cbar.TickLabelInterpreter = 'latex';
cbar.Label.Interpreter = 'latex';
text(par.zandvoort(1,1)-5e-4,par.zandvoort(2,1),'$\rightarrow$','Interpreter','latex','Rotation',atand(diff(par.zandvoort(2,1:2))/diff(par.zandvoort(1,1:2))),'FontSize',16)
hold off
axis equal
axis off
title('\textbf{Zandvoort Circuit} with Optimal Speed Profile','Interpreter','latex')

subplot(5,1,4:5)
plot(par.Distance,sol.v*3.6,'DisplayName','Optimal Speed Profile');
hold on;
plot(par.Distance,sqrt(par.E_max/par.m*2)*3.6,'k--','DisplayName','Speed Profile with only Tire Limits');
xlim([0 par.Distance(end)]);
grid on;
xlabel('Distance [m]','Interpreter','latex');
ylabel('Velocity [km/h]','Interpreter','latex');
set(gca,'TickLabelInterpreter','latex')
legend('Location','northoutside','Interpreter','latex','Orientation','horizontal')