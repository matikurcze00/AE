function if_all = parameters_check(x,y,a,b)
    if_all = 1;
    i = 1;
    err_count = 0;
    while i <= length(y) && if_all ~= 0
        if sign(x(i, 2)-(a.*x(i, 1)+b))== y(i)
            err_count = err_count+1;
            if_all = 0;
        end
        i = i+1;
    end
end