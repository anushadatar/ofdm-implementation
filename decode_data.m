function y_decoded = decode_data(y_time, number_of_blocks, block_size, prefix_size)
% TODO
% Assume 64 bit
    % Add 16 for each 64 TODO comment
    y_decoded = [];
    %pointer = 1;
    for i = 1:80:number_of_blocks*80 - 79
        next_block = fft(y_time(i+16:i+16+63));
        y_decoded = [y_decoded next_block];
        %pointer = pointer + 64;
    end
end