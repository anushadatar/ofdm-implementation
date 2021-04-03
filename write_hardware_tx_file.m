function write_hardware_tx_file(tx_data)
    % Formats the data and writes it to a text file for transmission using
    % a USRP B210 radio.
    % Input Parameters:
    % tx_data : The data to write to the file.
    % Returns:
    % Void, but writes data to file 'tx.dat' in this directory.
    
    % Add a buffer of zeroes before and after.
    buffer_width = 10000;
    tx_data = [zeros(buffer_width, 1); tx_data.'; zeros(buffer_width, 1)];
    
    % Interleave components.
    tmp = zeros(length(tx_data)*2, 1);
    tmp(1:2:end) = real(tx_data);
    tmp(2:2:end) = imag(tx_data);
    
    % Write to file tx.dat.
    f = fopen('tx.dat', 'wb');
    fwrite(f, tmp, 'float32');
    fclose(f);
end