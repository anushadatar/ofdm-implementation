function H_K = estimate_channel(x_train, block_size, prefix_size)
    % Estimate the impulse response of the channel using the training
    % signal known by both the transmitter and the receiver.
    % Input Parameters:
    % x_train     : The known training signal.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % H_k         : Vector (length block_size) representing the channel.

    % Number of training signals to average
    N = 100;

    % Create time domain signal and add cyclic prefix.
    x_time = ifft(x_train);
    x_cyclic = add_cyclic_prefix(x_time, prefix_size);

    % Averaged impulse response of the channel   
    H_K = zeros(1, block_size);

    for i = 1:N

        % Transmit signal across channel
        y_time = nonflat_channel(x_cyclic);

        % Account for received signal lag
        y_time = correct_lag(x_cyclic, y_time);

        % Get rid of cyclic prefix
        % todo BLOCK SIZE PREFIX SIZE
        y_time = y_time(17:17+63);

        % Put back in frequency domain and add to channel estimate.
        y = fft(y_time);
        h_k = y./x_train;
        H_K = H_K + h_k;
    end

    % Find average channel estimate
    H_K = H_K./N;
end
