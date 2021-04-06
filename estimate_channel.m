function H_K = estimate_channel(x_train, y_time, block_size, prefix_size, num_train)
    % Estimate the impulse response of the channel using the training
    % signal known by both the transmitter and the receiver.
    % Input Parameters:
    % x_train     : The known training signal.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi).
    % num_train   : The number of training blocks in the signal.
    % Returns:
    % H_k         : Vector (length block_size) representing the channel.
    
    % Get rid of cyclic prefix
    y_time_no_cyclic = decode_data(y_time, num_train, block_size, prefix_size);

    % Put back in frequency domain and add to channel estimate
    H_K_long = y_time_no_cyclic./x_train;
    H_K_r = reshape(H_K_long,[block_size,num_train]).';

    % Find average channel estimate
    H_K = mean(H_K_r,1);
    
    % Skip pilots to facilitate use with hardware.
    H_K = fftshift(H_K);
    %H_K_small = [H_K(8:25) H_K(27:32) H_K(34:39) H_K(41:58)];
    %stem(H_K_small)
end
