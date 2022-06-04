function d = point_to_line_dist(x, a, b)
    a = -a;
    c = -b;
    b = 1;
    d=abs(a*x(1)+b*x(2)+c)/sqrt(a.^2+b.^2);
