% GS1plot.m
% Initialization
clf, hold off, clear
% Compute matrices of objective function and constraint function values
% for combinations of x1 and x2
x1vec = [0.01:0.01:2.01];
x2vec = [0.01:0.01:2.01];
for j=1:1:length(x2vec)
    for i=1:1:length(x1vec)
        % Doint in design space
        x1=x1vec(i); x2=x2vec(j);
        % Dimensionless stresses in bars 1,2, and 3
        f1 = 0.5*sqrt(2)*( (sqrt(3)/(3*x1)) + 1/(x1+4*x2) );
        f2 = 2*sqrt(2)/(x1+4*x2);
        f3 = 0.5*sqrt(2)*( (-sqrt(3)/(3*x1)) + 1/(x1+4*x2) );
        % Objective function (mass)
        F(j,i) = 4*x1 + x2;
        % Tensile stress contraints
        g1(j,i) = f1 - 1;
        g2(j,i) = f2 - 1;
        g3(j,i) = f3 - 1;
        % Compression stress contraints
        g4(j,i) = -f1 - 1;
        g5(j,i) = -f2 - 1;
        g6(j,i) = -f3 - 1;
    end
end
contour(x1vec,x2vec, F, [2 4 6 8 10],'r:')
xlabel('x1'), ylabel('x2')
set(gca,'Xtick',[0.5:0.5:2])
set(gca,'Ytick',[0.5:0.5:2])
hold on
contour(x1vec, x2vec, g1, [0 0], 'k-')
contour(x1vec, x2vec, g2, [0 0], 'k-')
contour(x1vec, x2vec, g3, [0 0], 'k-') % Very small bump for small x1,x2
contour(x1vec, x2vec, g4, [0 0], 'k-') % Not visable
contour(x1vec, x2vec, g5, [0 0], 'k-') % Not visable
contour(x1vec, x2vec, g6, [0 0], 'k-')


