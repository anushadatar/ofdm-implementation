function [y_time] = correct_lag(x_cyclic, y_time)
    % Account for the fact that the received signal is lagging
    % behind the original signal. The correction is
    % done using the cross correlation.
    % Input Parameters:
    % x_cyclic : The transmitted signal with cyclic prefix.
    % y_time   : The signal received across the channel.
    % Returns:
    % y_time   : The received signal with the time delay removed.
    
    % Determine how much y1 is lagging
    [c1, lags1] = xcorr(abs(y_time), abs(x_cyclic));
    %stem(lags1,c1)
    [~, I1] = max(abs(c1));
    t_corr1 = lags1(I1)
    % Correct lag in y1 and add zeros to the end to account for shortened
    % length
    y_time = y_time(t_corr1+1:end);
    %y_time = y_time(8:end);
end