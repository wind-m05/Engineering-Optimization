function [objective,variables,constraints] = OCP(Distance,ds,par,s)
% function to frame the minimum lap time optimization problem

%% Calculate distance
N = length(Distance);%(S_N/ds);

%% Define Variables
% 
% State variables
%E_k     = mdlvar(N, s.E_k, 'state'); % J, kinetic energy
E_k = sdpvar(1,N);
% Input variables
%F_p     = mdlvar(N, s.F_p, 'input'); % N, propulsion force
%F_brk   = mdlvar(N, s.F_brk, 'input'); % N, brake force
F_p = sdpvar(1,N);
F_brk = sdpvar(1,N);
% Lifting variables
%dt      = mdlvar(N, s.dt, 'lifting'); % s, time between data points  
%v       = mdlvar(N, s.v, 'lifting'); % m/s, velocity
%F_drag  = mdlvar(N, s.F_drag, 'lifting'); % N, Aerodynamic drag
dt = sdpvar(1,N);
v = sdpvar(1,N);
F_drag = sdpvar(1,N);

%% Kinetic Energy
% Longitudinal force balance
%dE_kF = F_p.phy-F_drag.phy-F_brk.phy;
%dE_kF = F_p*s.F_p - F_drag*s.F_drag - F_brk*s.F_brk;
%% Define objective
% Objective function: minimize stint time
objective = sum(dt)*s.dt;%.phy);

%% Define constraints
constraints = [
    % Lethargy constraint
    cone([(v + dt*s.dt/ds)
        2*ones(1,N)/sqrt(s.v)
        (v - dt*s.dt/ds)]) 
    % Longitudinal force balance
    diff(E_k)==1/s.E_k*(0.5*(F_p(1:end-1)*s.F_p - F_drag(1:end-1)*s.F_drag - F_brk(1:end-1)*s.F_brk+F_p(2:end)*s.F_p - F_drag(2:end)*s.F_drag - F_brk(2:end)*s.F_brk)*ds) 
    % Aerodynamic dragforce   
    F_drag == par.rho*par.c_d*par.A_f*E_k*s.E_k/par.m/s.F_drag
    % Kinetic energy
    E_k >= 0.5*par.m*(v*s.v).^2/s.E_k    
    % Continuity
    E_k(1)==E_k(end)
    % Propulsion force bounds
    F_p<=1/s.F_p*par.F_max
    F_p<=1/s.F_p*par.P_max*dt*s.dt/ds
    F_p>=0
    % maximum kinetic energy
    E_k<=1/s.E_k*(par.E_max)
    % Braking direction
    F_brk>=0
];

%% Collect variables
variables.E_k = E_k;
variables.v = v;
variables.dt = dt;
variables.F_drag = F_drag;
variables.F_brk = F_brk;
variables.F_p = F_p;

% Collect opti vars and return
% ss = whos;
%     for i = 1:numel(ss)
%         if strcmp(ss(i).class,'mdlvar')
%             variables.(ss(i).name) = eval(ss(i).name);
%         end
%     end

end