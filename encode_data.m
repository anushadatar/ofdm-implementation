function x_cyclic = encode_data(x_data, block_size, prefix_size)
    % Encode data for transmission by appending the cyclic prefix.
    % Input Parameters:
    % x_data      : The data to encode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % x_cyclic    : The data vector encoded with the cyclic prefix.
    x_cyclic = [];
    for i = 1:block_size:length(x_data) - (block_size - 1)
        data_ifft = ifft(x_data(i:i+block_size-1));
        next_block = add_cyclic_prefix(data_ifft, prefix_size);
        x_cyclic = [x_cyclic next_block];
    end
end