function x_cyclic = encode_data(x_data)
% TODO
% Assume 64 bit
    x_time = ifft(x_data);
    % Add 16 for each 64 TODO comment
    x_cyclic = zeros(1, length(x_data) + length(x_data)/4);
    pointer = 1;
    for i = 1:64:length(x_data)-64
        next_block = add_cyclic_prefix(x_time(i:i+64));
        x_cyclic(pointer:pointer+80) = next_block;
        pointer = pointer + 80;
    end
end