function output_data = process_received_data(x_train, tx_cyclic, y_time, block_size, prefix_size, number_of_blocks, num_train)
% TODO

    % Account for received signal lag
    y_time_lag_corr = correct_lag(tx_cyclic, y_time);
    
    % Estimate Channel
    H_k = estimate_channel(x_train, y_time_lag_corr, block_size, prefix_size, num_train);
    
    % Get rid of cyclic prefix and put back in frequency domain.
    y_fft = decode_data(y_time_lag_corr(1.25*(length(x_train)+1):end), number_of_blocks, block_size, prefix_size);
    
    % Divide out the channel H_k
    channel_matrix = repmat(H_k, 1, number_of_blocks);
    output_data = y_fft./channel_matrix;
end