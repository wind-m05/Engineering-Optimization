clear all; close all; clc;

% LP
% yalmip('clear')
% % Plotting constraints
% x1 = [0:30];
% x2 = [0:30];
% [X1,X2] = meshgrid(x1,x2);
% figure() 
% hold on; 
% grid on;
% contourf(X1,X2,-(X1*5 + X2*8))
% plot(x1,(120-4*x1)/5,'k','linewidth',1)
% plot(x1,(60-5*x1)/3,'k','linewidth',1)
% hold on
% plot(x2, ones(size(x2))*30/2,'k','linewidth',1)
% yline(0,'linewidth',1)
% xline(0,'linewidth',1)
% 
% sdpvar x1 x2
% 
% % Define constraints 
% Constraints = [
%     (4*x1+5*x2-120<=0)
%     (5*x1+3*x2-60<=0)
%     (2*x2-30<=0)
%     (-x1<=0)
%     (-x2<=0)
% ];
% Objective = -(5*x1+8*x2);
% options = sdpsettings('verbose',1,'solver','gurobi');
% sol = optimize(Constraints,Objective,options);
% if sol.problem == 0
%  % Extract and display value
%  solution = [value(x1) value(x2)]
%  fval = value(Objective)
% else
%  display('Hmm, something went wrong!');
%  sol.info
%  yalmiperror(sol.problem)
% end

%% Quadratic programming

% x1 = [-10:0.1:10];
% x2 = [-10:0.1:10];
% [X1,X2] = meshgrid(x1,x2);
% f = ((X1-4).^2+(X2-4).^2);
% hold on
% contourf(X1,X2,f)
% plot(x1,(10-x1)/2,'k','linewidth',1)
% plot(x1,-15+7*x1,'k','linewidth',1)
% yline(0,'linewidth',1)
% xline(0,'linewidth',1)
% ylim([min(x2) max(x2)])
% 
% % Optimize
% yalmip('clear')
% sdpvar x1 x2
% Objective = ((x1-4)^2+(x2-4)^2);
% Constraints = [
%     (x1+2*x2-10<=0)
%     (7*x1-x2-15<=0)
%     (-x1<=0)
%     (-x2<=0)
% ];
% options = sdpsettings('verbose',1,'solver','gurobi');
% sol = optimize(Constraints,Objective,options);
% if sol.problem == 0
%  % Extract and display value
%  solution = [value(x1) value(x2)]
%  fval = value(Objective)
% else
%  display('Hmm, something went wrong!');
%  sol.info
%  yalmiperror(sol.problem)
% end

%% SDP
yalmip('clear')
X= sdpvar(3,3,'full');
C=[1,2,3;2,9,0;3,0,7];
A1=[1,0,1;0,3,7;1,7,5];
A2=[0,2,8;2,6,0;8,0,4];
b1=11;
b2=19;
obj= sum(sum(C.*X));
constraints= [
    sum(sum(A1.*X))== b1
    X >= 0
    sum(sum(A2.*X))== b2
    ];
options = sdpsettings('verbose',1,'solver','mosek');
% options = sdpsettings('verbose',1,'solver','fmincon');
sol=optimize(constraints,obj,options)
disp(value(X))

