function x_cyclic = encode_data(x_data, block_size, prefix_size)
% TODO
% Assume 64 bit
    % Add 16 for each 64 TODO comment
    %prefix_ratio = block_size/prefix_size; % Assumed whole number ratio
    x_cyclic = []; %zeros(1, length(x_data) + length(x_data)/prefix_ratio);
    %pointer = 1;
    for i = 1:block_size:length(x_data) - (block_size - 1)
        data_ifft = ifft(x_data(i:i+block_size-1));
        next_block = add_cyclic_prefix(data_ifft, prefix_size);
        x_cyclic = [x_cyclic next_block]; %x_cyclic(pointer : pointer+block_size+prefix_size-1) = next_block;
        %pointer = pointer + block_size+prefix_size;
    end
end