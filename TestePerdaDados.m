
EuroBavar_Files_Lying = ["Eurobavar/a001lb.txt";  "Eurobavar/a002lb.txt";"Eurobavar/a003lb.txt";  "Eurobavar/a004lb.txt";"Eurobavar/a005lb.txt";  "Eurobavar/a006lb.txt"; "Eurobavar/a007lb.txt";  "Eurobavar/a008lb.txt";"Eurobavar/b001lb.txt";  "Eurobavar/b002lb.txt";"Eurobavar/b003lb.txt";  "Eurobavar/b004lb.txt";"Eurobavar/b005lb.txt";  "Eurobavar/b006lb.txt"; "Eurobavar/b007lb.txt";  "Eurobavar/b008lb.txt";"Eurobavar/b009lb.txt";  "Eurobavar/b010lb.txt";"Eurobavar/b011lb.txt";  "Eurobavar/b012lb.txt";"Eurobavar/b013lb.txt"; ];
EuroBavar_Files_Standing = ["Eurobavar/a001sb.txt";  "Eurobavar/a002sb.txt"; "Eurobavar/a003sb.txt";  "Eurobavar/a004sb.txt";"Eurobavar/a005sb.txt";  "Eurobavar/a006sb.txt";  "Eurobavar/a007sb.txt";  "Eurobavar/a008sb.txt";   "Eurobavar/b001sb.txt";  "Eurobavar/b002sb.txt";  "Eurobavar/b003sb.txt";  "Eurobavar/b004sb.txt"; "Eurobavar/b005sb.txt";  "Eurobavar/b006sb.txt";  "Eurobavar/b007sb.txt";  "Eurobavar/b008sb.txt";  "Eurobavar/b009sb.txt";  "Eurobavar/b010sb.txt";"Eurobavar/b011sb.txt";  "Eurobavar/b012sb.txt";"Eurobavar/b013sb.txt";];  

seed = 1;
rng(seed);

close all

%figure(1)
wl = 0.1;
fs = 10*wl;
NumIMF = 1:2;
fp = 1;
range_f = [0.08 0.13];
suma = 3;
ii = 1;
jj = 1;

%table = ["Paciente" "Standing" "Lying"];
t = tic();
for p = 0:0.05:0.7

for eu=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21]
    % Assign the datasets to a variable
    clear data_standing data_lying RR_S RR_L MAP_S MAP_L T_S T_L 
    %table(ii+1,1) = [num2str(eu)];
    %Assign standing datasets to variables
    caminho_S = load(EuroBavar_Files_Standing(eu));
    caminho_L = load(EuroBavar_Files_Lying(eu));
    [MAP_S, RR_S, T_S, MAP_L, RR_L, T_L] = carregaDados(caminho_S, caminho_L, p);

    %subplot(2,21,ii)
    posicao = 'Standing';
    label = classificador2(RR_S, T_S, fp, range_f, NumIMF, suma);   
    table(ii,1) = label;
    %ii = ii + 1;
    
    %subplot(2,21,ii+21)
    posicao = 'Lying';
    label= classificador2(RR_L, T_L, fp, range_f, NumIMF, suma);    
    table(ii,2) = label;
    ii = ii + 1;
    
end
table_T(jj,1) = p;
table_T(jj,2) = sum(table(:,1));
table_T(jj,3) = sum(table(:,2));

table_com(:,1,jj) = table(:,1);
table_com(:,2,jj) = table(:,2);

jj = jj + 1;
ii = 1;
end
toc(t)

%%
figure;
bar(table_T(:,1)*100, [table_T(:,2), table_T(:,3)]);
xlabel('Porcentagem de perda de dados (%)');
ylabel('Número de pacientes');
ylim([0 15])

% Adicionar legenda
legend('Posição em pé', 'Posição em supino');



%%


for jj = 1:14
h = testcholdout(table_com(:,1,jj), table_com(:,1,1), table_com(:,1,1));
    if h == 1
        display(['Perda máxima para Standing: ' num2str(table_T(jj-1,1))])
        break
    end

end



for jj = 1:19
h = testcholdout(table_com(:,2,jj), table_com(:,2,1), table_com(:,2,1));
    if h == 1
        display(['Perda máxima para Lying: ' num2str(table_T(jj,1))])
        break
    end

end










