function temounao = classificador(MAP_S, T_S, fp, range_f, NumIMF, suma, eu, posicao)

Pfa = fp/100;
Pd = 1-Pfa;
fmax = 0.4;
pmax = 50;
imfMax = 3;

imf = emd(MAP_S,'MaxNumIMF',imfMax);
RR_RES = mean(imf(:,NumIMF),2);
[p, f, pth] = plomb(RR_RES,T_S,fmax, 'normalized','Pd',Pd);
plot(f,p)
hold on
idx = f <= range_f(2) & f >= range_f(1);
if sum(p(idx) >= pth) >= suma
    plot([0,fmax],[pth,pth], 'g-.')
    temounao = "Yes";
else
    plot([0,fmax],[pth,pth], 'r-.')
    temounao = "No";
end

title(['\fontsize{9}',posicao, ' - ', num2str(eu), temounao])
xlim([0 fmax])
ylim([0 pmax])
    



end