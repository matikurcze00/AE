function [out,g,H] = fun(x)
out=(1-x(1)+1)^2+100*(x(2)+1-(x(1)-1)^2)^2;
% syms x y
% f = (1-x+1)^2+100*(y+1-(x-1)^2)^2;
% h=hessian(f,[x,y])

H=[400*(x(1) - 1)^2 - 400*x(2) + 200*(2*x(1) - 2)^2 - 398, 400 - 400*x(1);
    400 - 400*x(1),  200];
%g=gradient(f,[x y])

g=[2*x(1) - 200*(2*x(1) - 2)*(x(2) - (x(1) - 1)^2 + 1) - 4;
200*x(2) - 200*(x(1) - 1)^2 + 200];

end
