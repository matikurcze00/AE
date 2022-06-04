function [pos_supv, neg_supv, m, m_width] = margin(x_pos,x_neg, a, b)
    neg_supv = [];
    pos_supv = [];
    pos_margin = 1000000;
    neg_margin = 1000000;
    a = -a;
    c = -b;
    b = 1;

    for i = 1:size(x_neg)
         d_neg=abs(a*x_neg(i, 1)+b*x_neg(i, 2)+c)/sqrt(a.^2+b.^2);
         if d_neg < neg_margin
             neg_supv=x_neg(i, :);
             neg_margin=d_neg;
         end
    end

    for i = 1:size(x_pos)
         d_pos=abs(a*x_pos(i, 1)+b*x_pos(i, 2)+c)/sqrt(a.^2+b.^2);
         if d_pos < pos_margin
             pos_supv=x_pos(i, :);
             pos_margin=d_pos;
         end
    end
    
    m_width=pos_margin+neg_margin;
    m = [neg_supv(1)-pos_supv(1), neg_supv(2)-pos_supv(2)];
end