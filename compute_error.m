function [err] = compute_error(rx_data, tx_data)
    % Compute the percent difference between the complete original signal
    % and the complete received signal. 
    % Input Parameters:
    % rx_data : Vector containing the decoded received signal.
    % tx_data : Vector containing the transmitted signal to compare
    %           against.
    % Returns:
    % err     : Percent error between transmitted and received message.
    rx_data = sign(real(rx_data));
    err = sum((rx_data ~= tx_data)) / length(tx_data);
end