function [output_data, error_rate] = simulate_with_synchronized_clocks(x_train, x_data)
    % Simulate sending and receiving data using OFDM.
    % x_train : The training signal to transmit across the channel.
    % x_data  : The data to transmit across the channel.
    % Returns:
    % output_data : The simulated decoded data.
    % error_rate  : The percent error between the simulated decoded data
    % and the original transmit data.
    
    % System parameters
    number_of_blocks = 100;  % Number of blocks in data sequence
    block_size = 64;         % Bits per block (not including prefix)
    prefix_size = 16;        % Prefix length in bits
    num_train = 100;          % Number of training blocks
    
    % Send multiple training sequences
    x_train = repmat(x_train, 1, num_train);
    
    % Package transmit data
    tx_cyclic = package_data(x_train, x_data, block_size, prefix_size);
    
    % transmit the signal
    y_time = nonflat_channel(tx_cyclic);
    
    output_data =  process_received_data(x_train, tx_cyclic, y_time, block_size, prefix_size, number_of_blocks, num_train);

    % Compute overall error
    error_rate = compute_error(output_data, x_data);
end
    