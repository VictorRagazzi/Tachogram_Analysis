function plota_lomb(MAP_S, T_S, posicao, Pfa, NumIMF, N_But, N_Gaus, range_f)


wl = 0.1;
fs = 10*wl;
Pfa = Pfa/100;
Pd = 1-Pfa;
fmax = 0.4;
pmax = 40;

subplot(4,1,1)
[p, f, pth] = plomb(MAP_S, T_S,fmax, 'normalized','Pd',Pd);
plot(f,p)
hold on
idx = find(f <= range_f(2) & f >= range_f(1));
if any(p(idx) >= pth)
    plot([0,fmax],[pth,pth], 'g-.')
else
    plot([0,fmax],[pth,pth], 'r-.')
end
title(['Sem processamento - ', posicao])
xlim([0 fmax])
ylim([0 pmax])
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Processamento EMD %
imf = emd(MAP_S,'MaxNumIMF',8);
RR_RES = mean(imf(:,NumIMF),2);
%RR_RES = mean(imf(:,[6:8]),2);
%%%%%%%%%%%%%%%%%%%%%

% Plota Processamento EMD %
subplot(4,1,2)
[p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
plot(f,p)
hold on
idx = find(f <= range_f(2) & f >= range_f(1));
if any(p(idx) >= pth)
    plot([0,fmax],[pth,pth], 'g-.')
else
    plot([0,fmax],[pth,pth], 'r-.')
end
title(['EMD - ', posicao])
xlim([0 fmax])
ylim([0 pmax])

%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Criação de Filtro + Filtragem %
f1 = 0.05;
f2 = 0.4;
n = N_But;
[B, A] = butter (n, [f1/(fs/2) f2/(fs/2)]);
%freqz(B,A,1024,fs);
RR_fil = filtfilt(B,A,MAP_S);
%plot(t_PP,RR_fil)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plota Filtro Butter    %
subplot(4,1,3)
[p, f, pth] = plomb(RR_fil, T_S,fmax, 'normalized','Pd',Pd);
plot(f,p)
hold on
idx = find(f <= range_f(2) & f >= range_f(1));
if any(p(idx) >= pth)
    plot([0,fmax],[pth,pth], 'g-.')
else
    plot([0,fmax],[pth,pth], 'r-.')
end
title(['Filtro ButterWorth - ', posicao])
xlim([0 fmax])
ylim([0 pmax])

%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plota Filtro Gaussiano %
subplot(4,1,4)
RR_fil = imgaussfilt(MAP_S,N_Gaus);
[p, f, pth] = plomb(RR_fil, T_S,fmax, 'normalized','Pd',Pd);
plot(f,p)
hold on
idx = find(f <= range_f(2) & f >= range_f(1));
if any(p(idx) >= pth)
    plot([0,fmax],[pth,pth], 'g-.')
else
    plot([0,fmax],[pth,pth], 'r-.')
end
title(['Filtro Gaussiano - ', posicao])
xlim([0 fmax])
ylim([0 pmax])

end