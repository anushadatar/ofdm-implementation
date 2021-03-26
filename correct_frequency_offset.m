function y_corrected = correct_frequency_offset(y_fft_train, y_fft, number_of_blocks)
    % TODO
    
    % Offset to skip the first 64-sample block
    offset = 64;
    
    % Vector for exponentials
    exponentials = zeros(1, offset);
    
    for i = 1:offset - 1
        exponentials(i) = angle(y_fft_train(i+2.*offset) ./ y_fft_train(i+offset));
    end
    
    % Take angle of all exponents and divide by 64
    f_delta_hat = 0.032 %(1/64).*sum(exponentials)
    
    % Return corrected signal
    exp_vector = exp(-1i*f_delta_hat*[1:length(y_fft)]);
    y_corrected = y_fft.*exp_vector;
    
end