function H_K = estimate_channel(x_train, y_time, block_size, prefix_size, num_train, f_delta_hat)
    % Estimate the impulse response of the channel using the training
    % signal known by both the transmitter and the receiver.
    % Input Parameters:
    % x_train     : The known training signal.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % H_k         : Vector (length block_size) representing the channel.
    % TODO update
    
    % Store all channel estimates in long vector   
    H_K = zeros(1, 64*num_train);

    % Get rid of cyclic prefix
    % todo BLOCK SIZE PREFIX SIZE
    y_time_no_cyclic = decode_and_correct_frequency_offset(y_time, num_train, block_size, prefix_size, f_delta_hat, 0);

    % Put back in frequency domain and add to channel estimate.git status
    H_K_long = y_time_no_cyclic./x_train;
    H_K_r = reshape(H_K_long,[64,num_train]).';

    % Find average channel estimate
    H_K = mean(H_K_r,1);
end
