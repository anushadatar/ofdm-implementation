function H_K = estimate_channel(x_train)
    % TODO

    % Will be our averaged impulse response of the channel   
    H_K = zeros(1, 64);
    
    % Numer of training signals to average
    N = 100;
    
    % Create time domain signal
    x_time = ifft(x_train);

    % Add cyclic prefix
    x_cyclic = add_cyclic_prefix(x_time);

    for i = 1:N
    
        % Transmit signal across channel
        y_time = nonflat_channel(x_cyclic);

        % Account for received signal lag
        y_time = correct_lag(x_cyclic, y_time);

        % Get rid of cyclic prefix
        y_time = y_time(17:17+63);

        % Put back in frequency domain
        y = fft(y_time);

        h_k = y./x_train;
        
        H_K = H_K + h_k;
   
    end
    
    H_K = H_K./N;
    
end