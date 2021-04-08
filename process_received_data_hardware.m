function [err, output_data] = process_received_data_hardware(rx_path, tx_path, x_train, x_data, block_size, prefix_size, number_of_blocks, num_train, num_preamb_blocks)
    % Process received data (OFDM signal sent over channel from a B210 USRP
    % and returns a BER and the raw output data.
    % Input Parameters:
    % rx_path           : Path to the received data .dat file
    % tx_path           : Path to the transmited data .dat file
    % x_train           : The raining signal vector.
    % x_data            : Original data bits to calculate BER
    % block_size        : The number of bits per block (64 for wifi).
    % prefix_size       : The number of bits in the prefix (16 for wifi).
    % number_of_blocks  : Number of data blocks.
    % num_train         : Number of training blocks.
    % num_preamb_blocks : The number of blocks of preamble data.
    %
    % Returns:
    % err               : BER as a decimal
    % output_data       : Corrected and decoded output data vector
    
    % padding on either side of tx
    buffer_width = 10000;
    
    % Unpack the raw data file for rx and tx
    rx = process_raw_data_file(rx_path);
    tx_cyclic = process_raw_data_file(tx_path);
    
    % Turn rx into row vector
    rx = rx.';
    
    % Trim tx vector
    cyclic_block_size = block_size + prefix_size;
    tx_cyclic = tx_cyclic(buffer_width:(buffer_width+block_size*num_preamb_blocks+block_size*num_train+cyclic_block_size*number_of_blocks-1));
    
    % Repeat x_train vector to make dividing easier
    x_train = repmat(x_train, 1, num_train);
    
    % Process received signal to get output data
    output_data = process_received_data(x_train, tx_cyclic, rx, block_size, prefix_size, number_of_blocks, num_train, num_preamb_blocks);
   
    % Calculate BER
    err = compute_error(output_data, x_data);
    
end