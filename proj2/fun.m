function [wartosc] = fun(x,items,W)
    waga=0;
    wartosc=0;
    for i=1:length(x)
        waga = waga+items(i,1)*x(i);
        wartosc = wartosc+items(i,2)*x(i);
    end
    if waga>W
        wartosc=wartosc/2+(W-waga)*100;
    end
end

