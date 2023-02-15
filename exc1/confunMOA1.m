function [g,h] = confunMOA1(x)
% confunASG1.m
% Design variables
x1 = x(1);
x2 = x(2);
% Stresses
s1 = 0.5*sqrt(2)*( sqrt(3)./(3*x1) + 1./(x1+4*x2) );
s2 = 2*sqrt(2)./(x1+4*x2);
s3 = 0.5*sqrt(2)*(-sqrt(3)./(3*x1) + 1./(x1+4*x2) );
% Constraints
g(1) = s1 - 1;
g(2) = s2 - 1;
g(3) = s3 - 1;
g(4) = -s1 - 1;
g(5) = -s2 - 1;
g(6) = -s3 - 1;
h = []; % no equality constraints
end

