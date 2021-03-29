function f_delta_hat = calculate_frequency_offset(y, block_size)
    % Calculate the frequency offset from the raw received signal (assuming
    % it contains a preamble 
    % Input Parameters:
    % y          : Raw received data to process.
    % block_size : The number of bits per block, used to skip the first
    %              block by offsetting indices. 
    % Returns:
    % f_delta_hat : Complex frequency correction factor.
    
    % Vector for exponentials
    exponentials = zeros(1, block_size);
    
    for i = block_size:2*block_size - 1
        exponentials(i-block_size+1) = angle(y(i+block_size+1) ./ y(i+1));
    end
    
    f_delta_hat = abs(mean(exponentials)./block_size)    
end