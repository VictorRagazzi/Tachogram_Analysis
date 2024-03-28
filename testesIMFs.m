
EuroBavar_Files_Lying = ["Eurobavar/a001lb.txt";  "Eurobavar/a002lb.txt";"Eurobavar/a003lb.txt";  "Eurobavar/a004lb.txt";"Eurobavar/a005lb.txt";  "Eurobavar/a006lb.txt"; "Eurobavar/a007lb.txt";  "Eurobavar/a008lb.txt";"Eurobavar/b001lb.txt";  "Eurobavar/b002lb.txt";"Eurobavar/b003lb.txt";  "Eurobavar/b004lb.txt";"Eurobavar/b005lb.txt";  "Eurobavar/b006lb.txt"; "Eurobavar/b007lb.txt";  "Eurobavar/b008lb.txt";"Eurobavar/b009lb.txt";  "Eurobavar/b010lb.txt";"Eurobavar/b011lb.txt";  "Eurobavar/b012lb.txt";"Eurobavar/b013lb.txt"; ];
EuroBavar_Files_Standing = ["Eurobavar/a001sb.txt";  "Eurobavar/a002sb.txt"; "Eurobavar/a003sb.txt";  "Eurobavar/a004sb.txt";"Eurobavar/a005sb.txt";  "Eurobavar/a006sb.txt";  "Eurobavar/a007sb.txt";  "Eurobavar/a008sb.txt";   "Eurobavar/b001sb.txt";  "Eurobavar/b002sb.txt";  "Eurobavar/b003sb.txt";  "Eurobavar/b004sb.txt"; "Eurobavar/b005sb.txt";  "Eurobavar/b006sb.txt";  "Eurobavar/b007sb.txt";  "Eurobavar/b008sb.txt";  "Eurobavar/b009sb.txt";  "Eurobavar/b010sb.txt";"Eurobavar/b011sb.txt";  "Eurobavar/b012sb.txt";"Eurobavar/b013sb.txt";];  

%%

close all

ii = 1;
figure(1)
wl = 0.1;
fs = 10*wl;
Pfa = 1;
Pfa = Pfa/100;
Pd = 1-Pfa;
fmax = 0.4;
pmax = 50;
posicao = 'Standing'; 
NumIMF = 1;
NumIMF2 = 2;
NumIMF3 = 1:2;
range_f = [0.08 0.13];
suma = 1;
imfMax = 3;

for eu=[4 11 14 16 17]
    % Assign the datasets to a variable
    clear data_standing data_lying RR_S RR_L MAP_S MAP_L T_S T_L 
    
    %Assign standing datasets to variables
    caminho_S = load(EuroBavar_Files_Standing(eu));
    caminho_L = load(EuroBavar_Files_Lying(eu));
    [MAP_S, RR_S, T_S, MAP_L, RR_L, T_L] = carregaDados(caminho_S, caminho_L, 0);
    MAP_S = RR_S;
    subplot(10,4,ii)
    [p, f, pth] = plomb(MAP_S, T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['Sem Proc. - ', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(NumIMF), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF2),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(NumIMF2), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    
    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF3),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = find(f <= range_f(2) & f >= range_f(1));
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(3), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    ii = ii + 1;
end

%ii = 1;
%figure(2)
posicao = 'Lying';

for eu=[21 20 15 18 19]
    clear data_standing data_lying RR_S RR_L MAP_S MAP_L T_S T_L 
    caminho_S = load(EuroBavar_Files_Standing(eu));
    caminho_L = load(EuroBavar_Files_Lying(eu));
    [MAP_S, RR_S, T_S, MAP_L, RR_L, T_L] = carregaDados(caminho_S, caminho_L, 0);
    
    MAP_S = RR_L;
    T_S = T_L;
    
    subplot(10,4,ii)
    [p, f, pth] = plomb(MAP_S, T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['Sem Proc. - ', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(NumIMF), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF2),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = f <= range_f(2) & f >= range_f(1);
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(NumIMF2), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])

    
    % Processamento EMD %
    imf = emd(MAP_S,'MaxNumIMF',imfMax);
    RR_RES = mean(imf(:,NumIMF3),2);
    ii = ii + 1;
    subplot(10,4,ii)
    [p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
    plot(f,p)
    hold on
    idx = find(f <= range_f(2) & f >= range_f(1));
    if sum(p(idx) >= pth) >= suma
        plot([0,fmax],[pth,pth], 'g-.')
    else
        plot([0,fmax],[pth,pth], 'r-.')
    end
    title(['EMD - ', num2str(3), ' -', posicao, ' - ', num2str(eu)])
    xlim([0 fmax])
    ylim([0 pmax])
    ii = ii + 1;
end



