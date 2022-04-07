set(0,'defaulttextinterpreter','latex');
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultStairLineWidth',1);

x=[3 2 0 0];
y=[0 -2 -2 0];
start=[3 0];
func = @(x)(1-x(1)+1)^2+100*(x(2)+1-(x(1)-1)^2)^2
f=@(x)[x(1) x(2)];


X=linspace(-3,5);
Z=zeros(100);
for i=1:100
    for j =1:100
        Z(i,j)=func([X(i) X(j)]);
    end
end
figure
contour(X,X,Z)
hold on;

% options = optimoptions('fminunc','Display','iter','OutputFcn', @outfun);
% [x,fval,exitflag,output,grad,hessian]=fminunc(func,start,options)


options = optimoptions('fminunc','Display','iter','Algorithm','trust-region','SpecifyObjectiveGradient',true,'OutputFcn', @outfun);
[x,fval,exitflag,output,grad,hessian]=fminunc(@fun,start,options)

% z=ga(func,2)
% func(z)

matlab2tikz('alg2_1.tex','showInfo', false);
