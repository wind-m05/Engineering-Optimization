clear all, close all, clc
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
    (-x1^2 -x2^2 + 4 <= 0)
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