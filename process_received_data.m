function output_data = process_received_data(x_train, tx_cyclic, y_time, block_size, prefix_size, number_of_blocks, num_train)
% TODO

    % Account for received signal lag
    y_time_lag_corr = correct_lag(tx_cyclic, y_time);
    
    % Calculate Frequenct Offset
    f_delta_hat = calculate_frequency_offset(y_time_lag_corr);
    
    % Estimate Channel
    H_k = estimate_channel(x_train, y_time_lag_corr, block_size, prefix_size, num_train, f_delta_hat);
    
    % Get rid of cyclic prefix and put back in frequency domain.
    y_fft = decode_and_correct_frequency_offset(y_time_lag_corr(1.25*(length(x_train)+1):end), number_of_blocks, block_size, prefix_size, f_delta_hat, 2400);
    
    % Divide out the channel H_k
    channel_matrix = repmat(H_k, 1, number_of_blocks);
    output_data = y_fft./channel_matrix;
end