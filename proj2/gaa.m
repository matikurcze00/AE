intcon = [1:1:32];
rng default % For reproducibility
A = [];
b = [];
Aeq = [];
beq = [];
lb = zeros(1,32);
ub = ones(1,32);
nonlcon = [];
[x,fval,exitflag,output,population,scores]  = ga(@fun,32,A,b,Aeq,beq,lb,ub,nonlcon,intcon);