function [x_pos, x_neg] = x_labels(x,y)
    x_pos = [];
    x_neg = [];
    for i=1:length(y)
        if y(i) == 1
            x_pos = [x_pos; x(i,:)];
        else
            x_neg = [x_neg; x(i,:)];
        end
    end
end

