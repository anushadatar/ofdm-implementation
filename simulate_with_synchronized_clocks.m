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
    
    H_k = estimate_channel(x_train);
    % Prepare transmit data.
    x_cyclic = encode_data(x_data);
    % Transmit signal across channel
    y_time = nonflat_channel(x_cyclic);

    % Account for received signal lag
    y_time = correct_lag(x_cyclic, y_time);

    % Get rid of cyclic prefix and pout back in frequency domain.
    y_time = decode_data(17:17+63);

    % Put back in frequency domain and add to channel estimate.
    y = fft(y_time);

    % Divide out the channel H_k
    