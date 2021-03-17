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
    number_of_blocks = 2;
    block_size = 64;
    prefix_size = 16;
    
    H_k = estimate_channel(x_train, block_size, prefix_size);
    % Prepare transmit data.
    x_time = ifft(x_data);
    x_cyclic = encode_data(x_time, block_size, prefix_size);
    y_time = nonflat_channel(x_cyclic);
    % Account for received signal lag
    y_time = correct_lag(x_cyclic, y_time);
    % Get rid of cyclic prefix and put back in frequency domain.
    y_time = decode_data(y_time, number_of_blocks, block_size, prefix_size);
    y = fft(y_time);

    % Divide out the channel H_k
    channel_matrix = repmat(H_k, 1, number_of_blocks);
    output_data = y./channel_matrix;
    output_data = sign(real(output_data));
    % Compute overall error
    error_rate = compute_error(output_data, x_data);
end
    