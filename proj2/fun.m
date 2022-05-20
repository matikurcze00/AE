function [wartosc] = fun(x)
    load('items.mat')
    W=0.3*sum(items(:,1));
    waga=0;
    wartosc=0;
    for i=1:length(x)
        waga = waga+items(i,1)*x(i);
        wartosc = wartosc+items(i,2)*x(i);
    end
    if waga>W
        wartosc=wartosc/1.5+(W-waga)*100;
    end
    %wykomentować jeśli nie korzystamy z ga()
    %wartosc=-wartosc;
end

