function tx_cyclic = package_data(x_train, x_data, block_size, prefix_size)
    % Package the existing transmit data
    % Input Parameters:
    % x_train     : The training signal to include in the data (including
    %               any additional preamble information).
    % x_data      : The data to transmit after the training signal.
    % block_size  : The number of bits per block (64 for wifi).
    % prefix_size : The number of bits in the prefix (16 for wifi).
    % Returns:
    % tx_cyclic   : Packaged transmit data with training signal and cyclic
    %               prefix encoding with ifft taken.

    % Construct tx signal by appending the training signal to the beginning
    % of the data signal
    tx = [x_train x_data];
    % Add cyclic prefixes and take the ifft
    tx_cyclic = encode_data(tx, block_size, prefix_size);
end