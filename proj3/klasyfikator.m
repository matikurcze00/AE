clear all;
load('skrypt_workspace.mat')

Eta = 0.7;
w = [1,1];
b = 0;
r = 0.1;

for j = 1:3
    for i = 1:20

        if (sign(w * x(i,:)' - b) ~= y(i))
            w = w + Eta*y(i)*x(i,:);
            b = b - Eta*y(i)*r^(2);
        end 
    end 
end 

suma = 0;

for i = 1:20

        if (sign(w * x(i,:)' - b) == y(i))
            suma = suma +1;
        end 
end 
suma
    
figure;
plot(x(1:10,1),x(1:10,2), '*')
hold on;
plot(x(11:20,1),x(11:20,2),'*')
X1=linspace(-3,5);
X2=linspace(-3,5);
plot(X1,w(1)*X1+w(2)*X2-b);
xlim([min(x(:,1))-0.05 max(x(:,1))]+0.05);