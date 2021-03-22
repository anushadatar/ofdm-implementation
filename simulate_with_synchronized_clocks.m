function [output_data, error_rate] = simulate_with_synchronized_clocks(x_train, x_data)
    % Simulate sending and receiving data with an SVD-based technique (i.e.
    % the scenario when both the transmitter and the receiver know the
    % channel parameters.
    % x_train : The training signal to transmit across the channel.
    % x_data  : The data to transmit across the channel.
    % Returns:
    % output_data : The simulated decoded data.
    % error_rate  : The percent error between the simulated decoded data
    % and the original transmit data.
    
    % System parameters
    number_of_blocks = 100;
    block_size = 64;
    prefix_size = 16;
    
    %Estimate the channel
    H_k = estimate_channel(x_train, block_size, prefix_size);
    
    % IFFT and add cyclic prefixes to each 64-sample block
    x_cyclic = encode_data(x_data, block_size, prefix_size);
    
    % transmit the signal
    y_time = nonflat_channel(x_cyclic);
    
    % Account for received signal lag
    y_time_lag_corr = correct_lag(x_cyclic, y_time);
    
    % Get rid of cyclic prefix and put back in frequency domain.
    y_fft = decode_data(y_time_lag_corr, number_of_blocks, block_size, prefix_size);

    % Divide out the channel H_k
    channel_matrix = repmat(H_k, 1, number_of_blocks);
    output_data = y_fft./channel_matrix;

    % Compute overall error
    error_rate = compute_error(output_data, x_data);
end
    