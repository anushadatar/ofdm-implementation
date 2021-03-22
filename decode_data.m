function y_decoded = decode_data(y_time, number_of_blocks, block_size, prefix_size)
    % Decode data on receipt by removing the cyclic prefix.
    % Input Parameters:
    % y_time      : The data to decode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % y_decoded   : The data vector with removed cyclic prefixes.
    
    y_decoded = [];
    for i = 1:80:number_of_blocks*80 - 79
        next_block = fft(y_time(i+16:i+16+63));
        y_decoded = [y_decoded next_block];
    end
end