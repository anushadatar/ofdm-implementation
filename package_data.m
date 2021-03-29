function tx_cyclic = package_data(x_train, x_data, block_size, prefix_size, num_preamb_blocks)
    % Package the existing transmit data to include the encoded training
    % data, encoded data to send, and a preamble.
    % Input Parameters:
    % x_train           : The training signal to include in the data.
    % x_data            : The data to transmit after the training signal.
    % block_size        : The number of bits per block (64 for wifi).
    % prefix_size       : The number of bits in the prefix (16 for wifi).
    % num_preamb_blocks : The number of blocks of preamble data to include. 
    % Returns:
    % tx_cyclic         : Packaged transmit data with the preamble followed
    %                     by the encoded and iffted training data and data
    %                     to transmit over the channel.

    % Construct tx signal by appending the training signal to the beginning
    % of the data signal
    tx = [x_train x_data];
    % Add cyclic prefixes and take the ifft
    tx_cyclic = encode_data(tx, block_size, prefix_size);
    
    % Create preamble and add it to the prepared signal
    preamb_block = sign(randn(1,block_size)) + sign(randn(1,block_size))*1i;
    preamb = repmat(preamb_block, 1, num_preamb_blocks);
    tx_cyclic = [preamb tx_cyclic];

end