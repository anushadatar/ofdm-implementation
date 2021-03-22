function y_decoded = decode_data(y_time, number_of_blocks, block_size, prefix_size)
    % Decode data on receipt by removing the cyclic prefix.
    % Input Parameters:
    % y_time      : The data to decode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % y_decoded   : The data vector with removed cyclic prefixes.
    y_decoded = [];
    cyclic_block_size = block_size + prefix_size;
    for i = 1:cyclic_block_size:number_of_blocks*(cyclic_block_size) - (cyclic_block_size - 1)
        next_block = y_time(i+prefix_size:i+cyclic_block_size - 1);
        y_decoded = [y_decoded next_block];
    end
end