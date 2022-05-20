clear;
% numerAlbumu=303763; %% Wpisz swój numer albumu
% rng(numerAlbumu);
N=32;
% items(:,1)=round(0.1+0.9*rand(N,1),1);
% items(:,2)=round(1+99*rand(N,1));
load('items.mat')
W=0.3*sum(items(:,1));
    maxi=[];
    srednie=[];
    mini=[];
    odchylenie=[];
    
%parametry algorytmu
rozmiar_populacji=2000;
rozmiar_elity=1;
liczba_iteracji=1000;
praw_mutacji=1/16;
liczba_pot_krzyz=500;
liczba_pot_mut=1000;

%inicjalizacja populacji
populacja = randi([0 1], rozmiar_populacji,N);

wartosc_f_celu=zeros(rozmiar_populacji,1);
for i=1:rozmiar_populacji
    wartosc_f_celu(i)=fun(populacja(i,:));
end

populacja=[populacja, wartosc_f_celu];
populacja= sortrows(populacja,N+1,{'descend'});

%for i=1:liczba_iteracji
while var(populacja(:,N+1))>20
    reprodukcja=[];
    praw_wyb_osobnika=(populacja(:,N+1)-min(populacja(:,N+1))+1);
    
    for k=2:rozmiar_populacji
        praw_wyb_osobnika(k) = praw_wyb_osobnika(k)+praw_wyb_osobnika(k-1);
    end
    
    ruletka=rand(1,rozmiar_populacji-rozmiar_elity)*max(praw_wyb_osobnika);
    
    for j=1:rozmiar_populacji-rozmiar_elity
        k=1;
        while k<=rozmiar_populacji
            if ruletka(j)<praw_wyb_osobnika(k)
                reprodukcja=[reprodukcja;populacja(k,:)];
                k=rozmiar_populacji+10;
            end
            k=k+1;
        end
    end
    
    for k=1:liczba_pot_krzyz
        para=randi([1,rozmiar_populacji-rozmiar_elity],1,2);
        przeciecie=randi([1,N-1],1,1);
        potomek1=[reprodukcja(para(1),1:przeciecie),reprodukcja(para(2),przeciecie+1:end)];
        potomek2=[reprodukcja(para(2),1:przeciecie),reprodukcja(para(1),przeciecie+1:end)];
        reprodukcja(para(1),:)=potomek1;
        reprodukcja(para(2),:)=potomek2;
    end
    pot_mut=randperm(rozmiar_populacji-rozmiar_elity,liczba_pot_mut);
    for k=1:liczba_pot_mut
        for j=1:N
            if rand(1,1)<praw_mutacji
                reprodukacja(pot_mut(k),j)=(reprodukcja(pot_mut(k),j)-1)^2;
            end
        end
    end
    
    wartosc_f_celu_rep=zeros(rozmiar_populacji-rozmiar_elity,1);
    
    for j=1:(rozmiar_populacji-rozmiar_elity)
        wartosc_f_celu_rep(j)=fun(reprodukcja(j,1:N));
    end
    reprodukcja(:,N+1)=[wartosc_f_celu_rep];
    populacja=[populacja(1:rozmiar_elity,:);reprodukcja];
    populacja= sortrows(populacja,N+1,{'descend'});
    
    maxi=[maxi populacja(1,N+1)];
    srednie=[srednie mean(populacja(:,N+1))];
    mini=[mini min(populacja(:,N+1))];
    odchylenie=[odchylenie var(populacja(:,N+1))];
    
    i
    populacja(1,N+1)
    srednie(end)
end
plot(maxi)
populacja(1,:)

