function H_K = estimate_channel(x_train, block_size, prefix_size)
    % Estimate the impulse response of the channel using the training
    % signal known by both the transmitter and the receiver.
    
    % Number of training signals to average
    N = 100;
    
    x_train = repmat(x_train, 1, N);
    % Create time domain signal and add cyclic prefix.
    x_cyclic = encode_data(x_train, block_size, prefix_size);
    
    % Averaged impulse response of the channel   
    H_K = zeros(1, 64*N);

    % Transmit signal across channel
    y_time = nonflat_channel(x_cyclic);

    % Account for received signal lag
    y_time_corr_lag = correct_lag(x_cyclic, y_time);

    % Get rid of cyclic prefix
    % todo BLOCK SIZE PREFIX SIZE
    y_time_no_cyclic = decode_data(y_time_corr_lag, N, block_size, prefix_size);

    % Put back in frequency domain and add to channel estimate.git status
    H_K_long = y_time_no_cyclic./x_train;
    H_K_r = reshape(H_K_long,[64,N]);
    % Find average channel estimate
    H_K = mean(H_K_r,2);
    H_K = H_K.';
end
