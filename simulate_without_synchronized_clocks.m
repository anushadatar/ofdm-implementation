function [output_data, error_rate] = simulate_without_synchronized_clocks(x_train, x_data, preamb_block)
    % Simulate sending and receiving data using OFDM across a channel that
    % introduces a frequency offset. 
    % x_train     : The training signal to transmit across the channel.
    % x_data      : The data to transmit across the channel.
    % Returns:
    % output_data : The simulated decoded data.
    % error_rate  : The percent error between the simulated decoded data
    %               and the original transmit data.
    
    % System parameters
    number_of_blocks = 100;  % Number of blocks in data sequence
    block_size = 64;         % Bits per block (not including prefix)
    prefix_size = 16;        % Prefix length in bits
    num_train = 30;          % Number of training blocks
    num_preamb_blocks = 3;   % Number of preamble blocks prior to training

    % Send multiple training sequences
    x_train = repmat(x_train, 1, num_train);
    
    % Package transmit data
    tx_cyclic = package_data(x_train, x_data, block_size, prefix_size, num_preamb_blocks, preamb_block);
    
    % Transmit the signal across the channel and process received data.
    y_time = nonflat_channel_timing_error(tx_cyclic);
    output_data =  process_received_data(x_train, tx_cyclic, y_time, block_size, prefix_size, number_of_blocks, num_train, num_preamb_blocks);
    
    % Compute overall error
    error_rate = compute_error(output_data, x_data);
end