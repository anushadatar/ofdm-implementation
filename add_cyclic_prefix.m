function x = add_cyclic_prefix(x, prefix_size)
    % Add the cyclic prefix to the signal by appending the specified number
    % of values from the end of the signal to the beginning of the signal.
    % Input Parameter:
    % x           : Input block without cyclic prefix.
    % prefix_size : The number of bits to include in the cyclic prefix.
    % Returns:
    % x : Block with cyclic prefix, length x + prefix_size.
    x = [x(length(x)-prefix_size + 1:end) x]; 
end