function [y_time] = correct_lag(x_cyclic, y_time)
    % Account for the fact that the signal received at y1 and y2 is lagging
    % behind those in x1 and x2 because of a time delay. The correction is
    % done using the cross correlation.
    % Input Parameters:
    % x1            : The signal sent from Tx1
    % x2            : The signal sent from Tx2
    % Returns:
    % y1            : The signal received by Rx1
    % y2            : The signal received by Rx2
    % TODO fix documentation
    
    % Determine how much y1 is lagging
    [c1, lags1] = xcorr(y_time, x_cyclic);
    [~, I1] = max(abs(c1));
    t_corr1 = lags1(I1);
    
    % Correct lag in y1 and add zeros to the end to account for shortened
    % length
    y_time = y_time(t_corr1:end);
end