function y_decoded = decode_and_correct_frequency_offset(y_time, number_of_blocks, block_size, prefix_size, f_delta_hat, offset)
    % Decode data on receipt by removing the cyclic prefix.
    % Input Parameters:
    % y_time      : The data to decode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % y_decoded   : The data vector with removed cyclic prefixes.
    
    y_decoded = [];
    for i = 1:80:number_of_blocks*80 - 79
        next_block = y_time(i+16:i+16+63);
        exp_vector = exp(-1i*f_delta_hat*[(i+16+offset):(i+16+63+offset)]);
        next_block_freq_corr = next_block.*exp_vector;
        next_block_fft = fft(next_block_freq_corr);
        y_decoded = [y_decoded next_block_fft];
    end
end