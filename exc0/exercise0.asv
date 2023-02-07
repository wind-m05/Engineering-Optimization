% Matlab file myfirstprogram.m

%% Problem 1 
f = [-3 -2];
A = [2 1; 1 1; 1 0];
b = [10 8 4];
Aeq = [];
beq = [];
lb = [0 0];
ub = [];
x = linprog(f,A,b,Aeq,beq,lb,ub)
% Intermezzo Plot the objective function
%% Objective function 1
x1 = 0:1:10;
x2 = 0:1:10;
[X1,X2] = ndgrid(x1,x2);
Z = -3*X1-2*X2;
surf(X1,X2,Z)
figure()
contour(X1,X2,Z)

%% Objective function 2
x1 = 0:1:10;
x2 = 0:1:10;
[X1,X2] = ndgrid(x1,x2);
Z = (X1.^2+X2.^2)-10*X1-10*X2+50;
figure()
surf(X1,X2,Z)
figure()
contour(X1,X2,Z)
%% Problem 2
f = [-10 -10];
H = 2*eye(2);
A = [2 1; 1 1; 1 0];
b = [10 8 4];
Aeq = [];
beq = [];
lb = [0 0];
ub = [];
x = quadprog(H,f,A,b,Aeq,beq,lb,ub)
%% Problem 3
x0 = [3 4];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0 0];
ub = [];
options = optimoptions('fmincon');
options = optimoptions(options,'Algorithm','interior-point');
x = fmincon(@objfun,x0,A,b,Aeq,beq,lb,ub,@nonlcon,options)
%% Objective function 
x1 = 0:1:10;
x2 = 0:1:10;
[X1,X2] = ndgrid(x1,x2);
Z = X1.^2+X2.^2;
figure()
surf(X1,X2,Z)
figure()
contour(X1,X2,Z)
%% Problem 4
[x_1,fval_1] = fminunc(@rosenbrock,[-1 1])

[x_2,fval_2] = fminsearch(@rosenbrock,[-1 1])