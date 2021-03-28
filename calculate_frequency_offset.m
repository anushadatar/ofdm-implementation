function f_delta_hat = calculate_frequency_offset(y)
    % TODO
    
    % Offset to skip the first 64-sample block
    offset = 64;
    
    % Vector for exponentials
    exponentials = zeros(1, 64);
    
    for i = offset:offset+63
        exponentials(i-offset+1) = angle(y(i+offset+1) ./ y(i+1));
    end
    
    f_delta_hat = abs(mean(exponentials)./64)
    
    % Take angle of all exponents and divide by 64
    %f_delta_hat = 0.032 %(1/64).*sum(exponentials)
    
    % Return corrected signal
    % exp_vector = exp(-1i*f_delta_hat*[1:length(y_fft)]);
    % y_corrected = y_fft.*exp_vector;
    
end