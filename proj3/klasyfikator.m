clear all;
format long;

load('skrypt_workspace.mat');

len = length(y);

[x_pos, x_neg] = x_labels(x,y);

% wybranie wersji
zadanie = 3;
if zadanie == 0
    % pozioma
    w = [0,1];
    b = 0;
elseif zadanie == 1
    % pionowa
    w = [1,0.1];
    b = 0;
elseif zadanie == 2
    %45 stopni
    w = [-1,1];
    b = 0;
elseif zadanie == 3
    %-45 stopni
    w = [1,1];
    b = 0;
end

%parametry
orth_w = [-w(2),w(1)];
a1 = (orth_w(2)/orth_w(1));
eta = 0.05;
r = calc_r(x);

error_counter = [];
w_tablica = [];
b_tablica = [];

while parameters_check(x,y,a1,b) ~= 1
    for i=1:len
        w_tablica = [w_tablica; w];
        b_tablica = [b_tablica; b];
        if sign(dot(w, x(i,:))-b) ~= y(i)
            w = w + eta*y(i)*x(i,:);
            b = b - eta*y(i)*r*r;
            orth_w = [-w(2),w(1)];
            a1 = (orth_w(2)/orth_w(1));
        end
        orth_w = [-w(2),w(1)];
        a1 = (orth_w(2)/orth_w(1));

        [pos_supv, neg_supv, m, m_width] = margin(x_pos, x_neg, a1, b);
        m_center = [pos_supv(1) + m(1)/2, pos_supv(2) + m(2)/2];
        
        if a1 >= 0
            b = b+point_to_line_dist(m_center, a1, b);
        else
            b = b-point_to_line_dist(m_center, a1, b);
        end

        %disp("distance");
        %disp(point_line_dist(m_center, a1, b));

        a = validacja(x,y,a1,b);
        error_counter = [error_counter; a];
    end
end

if length(w_tablica) == 0
    w_tablica = w
    b_tablica = b
    orth_w = [-w(2),w(1)];
    a1 = (orth_w(2)/orth_w(1));

    [pos_supv, neg_supv, m, m_width] = margin(x_pos, x_neg, a1, b);
    m_center = [pos_supv(1) + m(1)/2, pos_supv(2) + m(2)/2];
    
    if a1 >= 0
        b = b+point_to_line_dist(m_center, a1, b);
    else
        b = b-point_line_dist(m_center, a1, b);
    end
end

figure;
scatter(x_pos(:,1),x_pos(:,2), 'o','LineWidth',2);
hold on
scatter(x_neg(:,1),x_neg(:,2), 'x','LineWidth',2);
if orth_w(1) == 0
    orth_w(1) = 0.00001;
end
a1 = orth_w(2)/orth_w(1);
b1 = b;
f = @(x1) a1*x1 + b1;
fplot(f)
legend("klasa 1", "klasa -1", "granica")
title("Granica decyzyjna wyznaczona algorytmem uczenia perceptronu prostego")
xlim([-4,4])
ylim([-3,3])
% hold on;
% scatter(m_center(1), m_center(2))
% hold off;

figure;
orth_w_tab = [-w_tablica(:,2), w_tablica(:,1)];
a1_tab = orth_w_tab(:,2)./orth_w_tab(:,1);
b1_tab = b_tablica;
leg_arr = [];
hold on
t_shift = 0.2;
for j=1:length(b1_tab)
    f = @(x1) a1_tab(j)*x1 + b1_tab(j);
    fplot(f)
    leg_arr = [leg_arr, sprintf('a=%.4f b=%.4f it=%d;', a1_tab(j),b1_tab(j),j)];
    text(-0.5+t_shift*j,f(-0.5+t_shift*j),sprintf('%d',j))
end
% legend(split(leg_arr,';'))
title("Zmiany granicy decyzyjnej w kolejnych iteracjach")
xlim([-6,6])
ylim([-6,6])

figure;
plot3(w_tablica(:,1),w_tablica(:,2),1:length(w_tablica),'--om','LineWidth',2)
xlabel("w(1)")
ylabel("w(2)")
zlabel("iteracje")
title("Zmiany parametru 'w' w funkcji iteracji")

figure;
plot(b_tablica,'--o','LineWidth',2)
xlabel("iteracje")
ylabel("b")
title("Zmiany parametru 'b' w funkcji iteracji")

figure;
plot(error_counter,'--or','LineWidth',2);
xlabel("iteracje")
ylabel("b³¹d")
title("Zmiany liczby b³êdów w funkcji iteracji")