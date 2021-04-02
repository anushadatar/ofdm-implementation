function [ y ] = nonflat_channel_timing_error( x )
    % This is the function provided in class to simulate the channel for
    % the ofdm implementation with the timing error.
    % Input Paramters:
    % x : Some transmit vector to send through the channel.
    % Returns:
    % y : Received signal vector with channel impulse response and noise.

    SNR_dB = 30;  %nominal SNR in dB

    SNR = 10^(SNR_dB/10); % nominal SNR 

    % make an impulse response
    % this is done by upsampling and interpolating several
    % discrete points
    % the impulse response is shifted in time to insert a delay
    %
    tmp = [0 -0.1 1 -0.1 0.05 -0.01 0 0 0 0 ];
    tmp = resample(tmp, 10,9);
    h = zeros(64,1);
    h(8:8+length(tmp)-1) = tmp;

    % convolve input signal with channel impulse response
    y = conv(x,h);

    % generate frequency offset
    f_delta = pi*rand(1)/64

    % apply frequency offset
    y = y.*exp(1i*f_delta*[1:length(y)]);

    % compute appropriate noise variance to achive SNR
    noise_var = var(y)/SNR;

    % add noise of the appropriate variance
    y = y + sqrt(noise_var/2)*(randn(size(y)) + 1i*randn(size(y)));
end

