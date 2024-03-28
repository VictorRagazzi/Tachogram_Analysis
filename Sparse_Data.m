clear variables
close all
%% Create an array with the EuroBaVar dataset filenames
EuroBavar_Files_Lying = ["Eurobavar/a001lb.txt";  "Eurobavar/a002lb.txt";
                         "Eurobavar/a003lb.txt";  "Eurobavar/a004lb.txt"; 
                         "Eurobavar/a005lb.txt";  "Eurobavar/a006lb.txt";  
                         "Eurobavar/a007lb.txt";  "Eurobavar/a008lb.txt";   
                         "Eurobavar/b001lb.txt";  "Eurobavar/b002lb.txt";  
                         "Eurobavar/b003lb.txt";  "Eurobavar/b004lb.txt";
                         "Eurobavar/b005lb.txt";  "Eurobavar/b006lb.txt";  
                         "Eurobavar/b007lb.txt";  "Eurobavar/b008lb.txt";  
                         "Eurobavar/b009lb.txt";  "Eurobavar/b010lb.txt";
                         "Eurobavar/b011lb.txt";  "Eurobavar/b012lb.txt";
                         "Eurobavar/b013lb.txt"; 
                         ];


EuroBavar_Files_Standing = ["Eurobavar/a001sb.txt";  "Eurobavar/a002sb.txt";   
                            "Eurobavar/a003sb.txt";  "Eurobavar/a004sb.txt"; 
                            "Eurobavar/a005sb.txt";  "Eurobavar/a006sb.txt";  
                            "Eurobavar/a007sb.txt";  "Eurobavar/a008sb.txt";   
                            "Eurobavar/b001sb.txt";  "Eurobavar/b002sb.txt";  
                            "Eurobavar/b003sb.txt";  "Eurobavar/b004sb.txt"; 
                            "Eurobavar/b005sb.txt";  "Eurobavar/b006sb.txt";  
                            "Eurobavar/b007sb.txt";  "Eurobavar/b008sb.txt";  
                            "Eurobavar/b009sb.txt";  "Eurobavar/b010sb.txt";
                            "Eurobavar/b011sb.txt";  "Eurobavar/b012sb.txt";
                            "Eurobavar/b013sb.txt";
                            ];
  
%% Use a for loop to iterate through all the files
for eu=1:1:3
    % Assign the datasets to a variable
    clear data_standing data_lying RR_S RR_L MAP_S MAP_L T_S T_L 
    eu
    %Assign standing datasets to variables
    data_standing = load(EuroBavar_Files_Standing(eu));
    RR_S   = data_standing(:,1);
    MAP_S  = data_standing(:,4);
   
    %Form the time series for the dataset
    T_S = zeros(length(RR_S),1);
    T_S(1) = RR_S(1);
    for j = 2:1:length(RR_S)
         T_S(j) = T_S(j-1) + RR_S(j);
    end
    
    %Assign lying datasets to variables
    data_lying = load (EuroBavar_Files_Lying(eu));
    
    RR_L   = data_lying(:,1);
    MAP_L  = data_lying(:,4);
   
    %Form the time series for the dataset
    T_L = zeros(length(RR_L),1);
    T_L(1) = RR_L(1);
    for j = 2:1:length(RR_L)
         T_L(j) = T_L(j-1) + RR_L(j);
    end

    % Remove random data points
    SW = 5; %Switching period for the PRBS
    rand_int_S = round(rand(1,ceil(length(RR_S)/SW))); %Create a array of random of highs and lows
    rand_int_L = round(rand(1,ceil(length(RR_L)/SW)));
    Disturbance_S = zeros(1,length(rand_int_S)*5);
    Disturbance_L = zeros(1,length(rand_int_L)*5);
    %Create a PRBS with the correct switching period
    for i=0:1:length(rand_int_S)-1
    amp_S = rand_int_S(i+1);
        for j=1:1:SW
            Disturbance_S(SW*i+j)=amp_S;
        end
    end

    for i=0:1:length(rand_int_L)-1
    amp_L = rand_int_L(i+1);
        for j=1:1:SW
            Disturbance_L(SW*i+j)=amp_L;
        end
    end

    Disturbance_Short_S = Disturbance_S(1:length(MAP_S));
    Disturbance_Short_L = Disturbance_L(1:length(MAP_L));

    MAP_S_Sparse = Disturbance_Short_S' .*MAP_S;
    MAP_L_Sparse = Disturbance_Short_L' .*MAP_L;

    figure(eu)
    subplot(2,2,1)
    plot(T_S(1:100),MAP_S(1:100))
    hold on
    plot(T_S(1:100), MAP_S_Sparse(1:100),'*')
    ylim([min(MAP_S)-5 max(MAP_S)+5])
    xlabel('Time(s)')
    ylabel('MAP(mmHg)')
    legend('Complete dataset','Sparse dataset')
    %title(['Subject: ',num2str(eu),' - Standing'])

    subplot(2,2,2)
    plot(T_L,MAP_L)
    hold on
    plot(T_L, MAP_L_Sparse,'*')
    ylim([min(MAP_S)-5 max(MAP_S)+5])
    xlabel('Time(s)')
    ylabel('MAP(mmHg)')
    legend('Complete dataset','Sparse dataset')
    title(['Subject: ',num2str(eu),' - Lying'])

% Obtain the frequency spectrum for the complete datasets. 
    %Interpolate the data set to a regualr time interval
    interpolation_step_size = 2/3; % roughly the average RR interval
    T_reg_S = T_S(1):interpolation_step_size:T_S(end);
    MAPI_S = interp1(T_S,MAP_S,T_reg_S,'spline');
    MAPI_S = MAPI_S';

    N_S = length(T_reg_S);
    E_S = floor(N_S/2 +1);
    fs_S = 1/interpolation_step_size;
    bins_S = 1:E_S;
    f_S = ((bins_S)*fs_S)/N_S;

    %MAP Frequency Spectra
    MAPI_S = detrend(MAPI_S);
    MAPFFT_S = 2*abs(fft(MAPI_S)/N_S);
    MAPFFT_S = MAPFFT_S(1:E_S);

    figure(eu)
    subplot(2,2,2)
    plot(f,pxx)
    hold on
    subplot(2,2,3)
    plot(f_S,MAPFFT_S,'linewidth',1)
    grid on
    xlabel('Frequency (Hz)')
    title(['FFT of MAP. Subject: ',num2str(eu),' - Standing'])

    interpolation_step_size = 2/3; 
    T_reg_L = T_L(1):interpolation_step_size:T_L(end);
    MAPI_L = interp1(T_L,MAP_L,T_reg_L,'spline');
    MAPI_L = MAPI_L';

    N_L = length(T_reg_L);
    E_L = floor(N_L/2 +1);
    fs_L = 1/interpolation_step_size;
    bins_L = 1:E_L;
    f_L = ((bins_L)*fs_L)/N_L;

    %MAP Frequency Spectra
    MAPI_L = detrend(MAPI_L);
    MAPFFT_L = 2*abs(fft(MAPI_L)/N_L);
    MAPFFT_L = MAPFFT_L(1:E_L);

    subplot(2,2,4)
    plot(f_L,MAPFFT_L,'linewidth',1)
    grid on
    xlabel('Frequency (Hz)')
    title(['FFT of MAP. Subject: ',num2str(eu),' - Lying'])

end