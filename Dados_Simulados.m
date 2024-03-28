clear; clc

hr = 60;
wl = 2*pi*0.095;
wh = 2*pi*0.275;
fs = 10*wl/(2*pi);
%fs = 500;
t = 0:1/fs:300;
al = 2;
ah = 2.5;

S = hr + al*sin(wl*t) + ah*sin(wh*t);
RR = 60./S;
%% Plotaaaaaaaaar

subplot(2,1,1)
plot(t,RR,'or')
hold on
plot(t,RR,'b')

subplot(2,1,2)
plomb(RR,t,0.4)

%%

idx = randperm(size(S,2));
S_dis = S;
S_dis(:,idx(1:0.2*length(S))) = NaN;
S_plot = 60./S_dis;
%t(:,idx(1:0.2*length(S))) = [];
t_plt = 0:1/476.666:300;
ruido_plt = randn(1,length(t_plt))/5+1;
ruido_vc = randn(1,length(S_dis))/5;
ruido = randn(1,length(S_dis))+1;


subplot(2,1,1)
plot(t_plt,ruido_plt, 'b')
hold on
plot(t,S_plot,'or')


S_dis = S_dis + ruido;
RR_dis = 60./S_dis;

[p, f] = plomb(RR_dis,t,0.4);            % Sinal
[p_vc, f_vc] = plomb(ruido_plt,t_plt);          % Ruido

Neff = 0.4*1/(fs);
Psingle = 1 - exp(-p);                   % Sinal
P_vc = 1 - exp(-p_vc);                   % Ruido

FAP = Psingle.^Neff;                     % Sinal
FAP_vc = P_vc.^Neff;                     % Ruido

Pfa1 = quantile(FAP_vc(1:481), 1-0.01);
Pfa10 = quantile(FAP_vc(1:481), 1-0.1);
Pfa50 = quantile(FAP_vc(1:481), 1-0.5);

subplot(2,1,2) 

plot(f,FAP)
%hold on 
yline(Pfa1,'m', 'Pfa = 1')
yline(Pfa10,'y', 'Pfa = 10')
yline(Pfa50,'r', 'Pfa = 50')


%% TIRA DADOS NaN %
RR_PP = RR_dis;
RR_PP(find(isnan(RR_dis) == 1)) = [];
t_PP = t;
t_PP(find(isnan(RR_dis) == 1)) = [];
%%%%%%%%%%%%%%%%%%%

%% Pré processamento 

% Plota Lomb padrão %
subplot(4,1,1)
[p, f] = plomb(RR_dis, t,0.4);
Psingle = 1 - exp(-p);                   % Sinal
FAP = Psingle.^Neff;                     % Sinal
plot(f,FAP)
title('Sem processamento')
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Processamento EMD %
imf = emd(RR_PP,'MaxNumIMF',8);
RR_RES = mean(imf(:,[1:3]),2);
%RR_RES = mean(imf(:,[6:8]),2);
%%%%%%%%%%%%%%%%%%%%%

% Plota Processamento EMD %
[p, f] = plomb(RR_RES,t_PP,0.4);
Psingle = 1 - exp(-p);                   % Sinal
FAP = Psingle.^Neff;                     % Sinal
subplot(4,1,2)
plot(f,FAP)
title('EMD')
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Criação de Filtro + Filtragem %
f1 = 0.05;
f2 = 0.4;
n = 3;
[B, A] = butter (n, [f1/(fs/2) f2/(fs/2)]);
%freqz(B,A,1024,fs);
RR_fil = filtfilt(B,A,RR_PP);
%plot(t_PP,RR_fil)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plota Filtro Butter    %
subplot(4,1,3)
[p, f] = plomb(RR_fil, t_PP,0.4);
Psingle = 1 - exp(-p);                   % Sinal
FAP = Psingle.^Neff;                     % Sinal
plot(f,FAP)
title('Filtro ButterWorth')
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plota Filtro Gaussiano %
RR_fil = imgaussfilt(RR_PP,0.6);
subplot(4,1,4)
[p, f] = plomb(RR_fil, t_PP,0.4);
Psingle = 1 - exp(-p);                   % Sinal
FAP = Psingle.^Neff;                     % Sinal
plot(f,FAP)
title('Filtro Gaussiano')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Monte carlo

hr = 60;
wl = 2*pi*0.095;
wh = 2*pi*0.275;
fs = 10*wl/(2*pi);
%fs = 500;
t_mc = 0:1/fs:530000;
al = 2;
ah = 2.5;

S = hr + 5*randn(1,length(t_mc));
RR_mc = 60./S;

subplot(2,1,1)
plot(t_mc,S)
title('Ruído Gaussiano')

[p_mc, f_mc] = plomb(RR_mc, t_mc, 0.4);
%p_mc = p_mc/max(p_mc);

subplot(2,1,2)
plot(f_mc, p_mc)
title('Ruído no Domínio da Frequência')

%%

alpha = 0.005;
vc_mc = quantile(p_mc,1-alpha)
plot(f_mc, p_mc)
hold on
plot([0,0.4],[vc_mc,vc_mc], 'r-.')
xlim([0 0.4])

%%












