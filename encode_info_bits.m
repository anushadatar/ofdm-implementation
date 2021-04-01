function x_cyclic = encode_info_bits(x_data, block_size, prefix_size)
    % Encode data for transmission by appending the cyclic prefix.
    % Input Parameters:
    % x_data      : The data to encode.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi)
    % Returns:
    % x_cyclic    : The data vector encoded with the cyclic prefix.
    x_cyclic = [];
    for i = 1:(block_size - prefix_size):length(x_data) - (block_size - prefix_size - 1)
        block = zeros(1, block_size);
        data_pointer = 0;
        for m = 1:block_size
            if (m <= 6)
                block(m) = 0;
            elseif (m == 33)
                block(m) = 0;
            elseif (m >= 60)
                block(m) = 0;
            elseif (m == 7)
                block(m) = 1;
            elseif (m == 26)
                block(m) = 1;
            elseif (m == 40)
                block(m) = 1;
            elseif (m == 59)
                block(m) = 1;
            else
                block(m) = x_data(i+data_pointer);
                data_pointer = data_pointer + 1;
            end
        end
        block_shift = fftshift(block);
        data_ifft = ifft(block_shift);
        next_block = add_cyclic_prefix(data_ifft, prefix_size);
        x_cyclic = [x_cyclic next_block];
    end
end