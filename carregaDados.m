function [MAP_S, RR_S, T_S, MAP_L, RR_L, T_L] = carregaDados(caminho_S, caminho_L, p)

    data_standing = caminho_S;
    RR_S   = data_standing(:,1);
    MAP_S  = data_standing(:,4);
    
    %Form the time series for the dataset
    T_S = zeros(length(RR_S),1);
    T_S(1) = RR_S(1);
    for j = 2:1:length(RR_S)
         T_S(j) = T_S(j-1) + RR_S(j);
    end
    
    %Assign lying datasets to variables
    data_lying = caminho_L;
    
    RR_L   = data_lying(:,1);
    MAP_L  = data_lying(:,4);
   
    %Form the time series for the dataset
    T_L = zeros(length(RR_L),1);
    T_L(1) = RR_L(1);
    for j = 2:1:length(RR_L)
         T_L(j) = T_L(j-1) + RR_L(j);
    end

    n = floor(p*length(MAP_S));
    % Gere um vetor com os índices dos dados a serem removidos
    zerar = randperm(length(MAP_S),n);
    % Remova os dados
    MAP_S(zerar) = [];
    T_S(zerar) = [];
    RR_S(zerar) = [];
    
    n = floor(p*length(MAP_L)); 
    zerar = randperm(length(MAP_L),n);    
    MAP_L(zerar) = [];
    T_L(zerar) = [];
    RR_L(zerar) = [];

    
end