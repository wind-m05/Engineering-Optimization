clear all, close all, clc
lb = [0,0];
ub = [];
A = [];
b = [];
Aeq = [];
beq = [];
x0 = [2,2];
x = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@constr);
x
%% sol 
% MOA1g.m
options = optimoptions('fmincon');
options = optimoptions(options,'Display','Iter');
% Initial guess
x0 = [2.0 2.0];
% Lower and upper bounds
lb = [0.00001 0.00001];
ub = [inf inf];
[x,fval,exitflag,output,lambda,grad]=...
fmincon(@objfunMOA1,x0,[],[],[],[],lb,ub,@confunMOA1,options);
x
fval
exitflag %% Same answer...
