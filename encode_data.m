function x_cyclic = encode_data(x_data, block_size, prefix_size)
    % Encode data for transmission by appending the cyclic prefix.
    % Input Parameters:
    % x_data      : The data to encode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % x_cyclic    : The data vector encoded with the cyclic prefix.
    prefix_ratio = block_size/prefix_size; % Assume whole number ratio
    x_cyclic = zeros(1, length(x_data) + length(x_data)/prefix_ratio);
    pointer = 1;
    for i = 1:block_size:length(x_data) - (block_size - 1)
        next_block = add_cyclic_prefix(x_data(i:i+block_size-1), prefix_size);
        x_cyclic(pointer : pointer+block_size+prefix_size-1) = next_block;
        pointer = pointer + block_size+prefix_size;
    end
end