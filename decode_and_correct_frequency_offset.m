function y_decoded = decode_and_correct_frequency_offset(y_time, number_of_blocks, block_size, prefix_size, f_delta_hat, offset)
    % Decode data on receipt by removing the cyclic prefix.
    % Input Parameters:
    % y_time           : The data to decode.
    % number_of_blocks : The number of blocks in the data.
    % block_size       : The number of bits per block (64 for wifi).
    % prefix_size      : The number of bits in the prefix (16 for wifi)
    % f_delta_hat      : The frequency offset correction factor.
    % offset           : Timing offset needed for frequency correction.
    % Returns:
    % y_decoded        : The data vector with removed cyclic prefixes.
    
    y_decoded = [];
    prefixed_block_size = block_size + prefix_size;    
    for i = 1:prefixed_block_size:number_of_blocks*prefixed_block_size - prefixed_block_size + 1
        next_block = y_time(i+prefix_size:i+prefixed_block_size - 1);
        exp_vector = exp(-1i*f_delta_hat*[(i+prefix_size+offset):(i+prefixed_block_size - 1 + offset)]);
        next_block_freq_corr = next_block.*exp_vector;
        next_block_fft = fft(next_block_freq_corr);
        y_decoded = [y_decoded next_block_fft];
    end
end