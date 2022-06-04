function r = calc_r(x)
    all_r = zeros(length(x),1);
    for i=1:length(x)
        all_r(i) = norm(x(i,:));
    end
    r = max(all_r);
end

