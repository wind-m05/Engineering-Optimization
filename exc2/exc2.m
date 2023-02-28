clear all, close all, clc
% yalmip('clear')
% n = 5;
% m = 5;
% P = sdpvar(n,m,'full');
% Constraints = [sum(sum(P)) >= 3];
% for i = 1 : 3
% Constraints = [Constraints, P(i,i) + P(i+1,i+1) <= P(i+2,i+2)];
% end
% my_tolerance_for_strict = 1e-3;
% F = [0 <= P(1,1) <= 2-my_tolerance_for_strict];
% 
% Objective = norm(P,1);
% options = sdpsettings('verbose',1,'solver','gurobi',...
% 'quadprog.maxiter',100);
% sol = optimize(Constraints,Objective,options);
% if sol.problem == 0
% solution = value(P);
% else
% display('Hmm, something went wrong!');
% sol.info
% yalmiperror(sol.problem)
% end
%% Doing yourself
%Cleaning yalmip workspace
yalmip('clear')
%Variables declaration
x1 = sdpvar(1,1);
x2 = sdpvar(1,1);
%Constraints definition
Constraints = [
    (-x1 -x2 <=0)
    ((x1)^2 + (x2)^2 - 9 <= 0)
    -x1^2 -x2^2 + 4 <= 0
];
Objective = (x1)^2+2*(x2)^2;
% Setting options for YALMIP and solver
options = sdpsettings('verbose',1,'solver','gurobi');
% Try different solvers (which one work and why?)
% Solving the problem
sol = optimize(Constraints,Objective,options);
% Analyzing error flags
if sol.problem == 0
     % Extracting and displaying value
     solution = [value(x1)  value(x2)] 
else
 display('something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
%% Always check your solutions!
%Assembling functions to be plotted
x1plot = [-5:0.1:5];
x2plot = [-5:0.1:5];
[X, Y] = meshgrid(x1plot,x2plot);
obj = X.^2 + 2*Y.^2;
syms x y
figure; 
grid on; 
hold on; 
axis equal;
fimplicit((x).^2 + (y).^2 -4,'r')
fimplicit((x).^2 + (y).^2 -9,'r')
fimplicit(-x - y,'r')
hold on
contour(X,Y,obj,-10:1:10)
plot(solution(1),solution(2),'r x','linewidth',6)
hold off