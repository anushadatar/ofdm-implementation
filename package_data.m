function tx_cyclic = package_data(x_train, x_data, block_size, prefix_size)
% TODO

    % Construct tx signal
    tx = [x_train x_data];
    
    % Add cyclic prefixes/ifft
    tx_cyclic = encode_data(tx, block_size, prefix_size);
end