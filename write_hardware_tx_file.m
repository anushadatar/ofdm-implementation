function write_hardware_tx_file(tx_data)
    % TODO
    buffer_width = 10000;
    tx_data = [zeros(buffer_width, 1); tx_data.'; zeros(buffer_width, 1)];
    tmp = zeros(length(tx_data)*2, 1);
    tmp(1:2:end) = real(tx_data);
    tmp(2:2:end) = imag(tx_data);
    f = fopen('tx.dat', 'wb');
    fwrite(f, tmp, 'float32');
    fclose(f);
end