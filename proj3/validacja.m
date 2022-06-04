function err_count = validacja(x,y,a,b)
    err_count = 0;
    for i=1:length(y)
        if sign(x(i, 2)-(a.*x(i, 1)+b))== y(i)
            err_count = err_count+1;
        end
    end
end

