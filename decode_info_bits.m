function x_decoded = decode_info_bits(y_time, block_size, prefix_size)
    % TODO
    x_decoded = [];
    num_pilots = 4;
    prefixed_block_size = block_size + prefix_size;
    for i = 1:prefixed_block_size:length(y_time) - (prefixed_block_size - 1)
        next_block = fft(y_time(i+prefix_size:i+prefixed_block_size - 1));
        next_block_shifted = fftshift(next_block);
        x_decoded_uncorrected = [];
        phase_offset = 0;
        for m = 1:block_size
            if (m <= 6)
                continue;
            elseif (m == 33)
                continue;
            elseif (m >= 60)
                continue;
            elseif (m == 7)
                phase_offset = phase_offset + angle(next_block_shifted(m));
            elseif (m == 26)
                phase_offset = phase_offset + angle(next_block_shifted(m));
            elseif (m == 40)
                phase_offset = phase_offset + angle(next_block_shifted(m));
            elseif (m == 59)
                phase_offset = phase_offset + angle(next_block_shifted(m));
            else
                x_decoded_uncorrected = [x_decoded_uncorrected next_block_shifted(m)];
            end
        end
        phase_offset = phase_offset / num_pilots;
        x_decoded_corrected = x_decoded_uncorrected.*exp(-1i*phase_offset);
        x_decoded = [x_decoded x_decoded_corrected]; 
    end
    