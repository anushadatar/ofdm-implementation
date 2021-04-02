function output_data = process_received_data(x_train, tx_cyclic, y_time, block_size, prefix_size, number_of_blocks, num_train, num_preamb_blocks)
    % Process received data (OFDM signal sent over channel that introduces
    % a frequency offset) and return the cleaned, decoded output vector.
    % Input Parameters:
    % x_train           : The raining signal vector.
    % tx_cyclic         : The tx data signal; must include preamble and
    %                     training signal.
    % y_time            : The raw received data vector to decode.
    % block_size        : The number of bits per block (64 for wifi).
    % prefix_size       : The number of bits in the prefix (16 for wifi).
    % number_of_blocks  : Number of data blocks.
    % num_train         : Number of training blocks.
    % num_preamb_blocks : The number of blocks of preamble data.
    % Returns:
    % output_data       : The corrected and decoded data vector.

    % Account for received signal lag
    lag_offset = 5; % Number of additional signal to provide to correct_lag
    y_time_lag_corr = correct_lag(tx_cyclic(1:(block_size - 1)*num_preamb_blocks*lag_offset), y_time);
    
    % Calculate frequency Offset
    f_delta_hat = calculate_frequency_offset(y_time_lag_corr(1:(block_size*num_preamb_blocks)), block_size);
    
    % Correct frequency offset
    exp_vector = exp(-1i*f_delta_hat*[1:length(y_time_lag_corr)]);
    y_time_lag_corr = y_time_lag_corr.*exp_vector;
    
    % Cut off preamble
    y_time_lag_corr = y_time_lag_corr(block_size*num_preamb_blocks+1:end);
    
    % Estimate Channel
    H_k = estimate_channel(x_train, y_time_lag_corr, block_size, prefix_size, num_train);
    
    % Get rid of cyclic prefix and put back in frequency domain.
    % y_fft = decode_data(y_time_lag_corr(((block_size + prefix_size)/block_size)*(length(x_train)+1):end), number_of_blocks, block_size, prefix_size);
    y_fft = decode_info_bits(y_time_lag_corr(((block_size + prefix_size)/block_size)*(length(x_train)+1):end), block_size, prefix_size);
    % Divide out the channel H_k
    channel_matrix = repmat(H_k, 1, number_of_blocks);
    output_data = y_fft./channel_matrix;
end