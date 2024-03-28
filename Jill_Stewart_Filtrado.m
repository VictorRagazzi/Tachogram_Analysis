
EuroBavar_Files_Lying = ["Eurobavar/a001lb.txt";  "Eurobavar/a002lb.txt";"Eurobavar/a003lb.txt";  "Eurobavar/a004lb.txt";"Eurobavar/a005lb.txt";  "Eurobavar/a006lb.txt"; "Eurobavar/a007lb.txt";  "Eurobavar/a008lb.txt";"Eurobavar/b001lb.txt";  "Eurobavar/b002lb.txt";"Eurobavar/b003lb.txt";  "Eurobavar/b004lb.txt";"Eurobavar/b005lb.txt";  "Eurobavar/b006lb.txt"; "Eurobavar/b007lb.txt";  "Eurobavar/b008lb.txt";"Eurobavar/b009lb.txt";  "Eurobavar/b010lb.txt";"Eurobavar/b011lb.txt";  "Eurobavar/b012lb.txt";"Eurobavar/b013lb.txt"; ];
EuroBavar_Files_Standing = ["Eurobavar/a001sb.txt";  "Eurobavar/a002sb.txt"; "Eurobavar/a003sb.txt";  "Eurobavar/a004sb.txt";"Eurobavar/a005sb.txt";  "Eurobavar/a006sb.txt";  "Eurobavar/a007sb.txt";  "Eurobavar/a008sb.txt";   "Eurobavar/b001sb.txt";  "Eurobavar/b002sb.txt";  "Eurobavar/b003sb.txt";  "Eurobavar/b004sb.txt"; "Eurobavar/b005sb.txt";  "Eurobavar/b006sb.txt";  "Eurobavar/b007sb.txt";  "Eurobavar/b008sb.txt";  "Eurobavar/b009sb.txt";  "Eurobavar/b010sb.txt";"Eurobavar/b011sb.txt";  "Eurobavar/b012sb.txt";"Eurobavar/b013sb.txt";];  

%%

ii = 1;
for eu=[4 11 14 16 17]
    % Assign the datasets to a variable
    clear data_standing data_lying RR_S RR_L MAP_S MAP_L T_S T_L 
    
    %Assign standing datasets to variables
    caminho_S = load(EuroBavar_Files_Standing(eu));
    caminho_L = load(EuroBavar_Files_Lying(eu));
    [MAP_S, RR_S, T_S, MAP_L, RR_L, T_L] = carregaDados(caminho_S, caminho_L, 0);
    figure(ii)
    sgtitle(['Paciente ', num2str(eu)])
    
    Pd = 1; % Probabilidade de Detecção 
    range_f = [0.04 0.15]; % Intervalo de Frequência Mayer's Waves    
    
    plota_lomb(MAP_S, T_S, 'Standing', Pd, 1:3, 3, 0.9, range_f)
    ii = ii + 1;
    figure(ii)
    sgtitle(['Paciente ', num2str(eu)])
    plota_lomb(MAP_L, T_L, 'Lying', Pd, 1:3, 3, 0.9, range_f)

    ii = ii+1;
end





