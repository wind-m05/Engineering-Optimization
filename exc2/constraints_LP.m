x1 = [0:30];
x2 = [0:30];
[X1,X2] = meshgrid(x1,x2);
figure; box on; hold on; grid on;
contourf(X1,X2,-(X1*5 + X2*8))
plot(x1,(120-4*x1)/5,'k','linewidth',3)
plot(x1,(60-5*x1)/3,'k','linewidth',3)
yline(15)
yline(0,'linewidth',3)
xline(0,'linewidth',3)
