function [signal] = overlapAndAdd(stft,sigLen,winlen,hopsize,fftlength)
%
% Description: Function to resynthsize signal from complex STFT 
%
% Inputs
%   - stft: short-time Fourier transform
%
%   - sigLen: Length of the time domain signal
%
%   - winlen: Length of the window when computed the STFT
%
%   - fftlength: Size of the FFT
%
%   - hopsize: Hop size used in STFT calculation
%
% Outputs
%   - signal: time domain signal

fullFFT = double([stft; flipud(conj(stft(2:fftlength/2, :)))]);


signal = zeros(sigLen*2,1);
window = hann(winlen);

%% overlap-and-add
for i = 1:size(fullFFT, 2)
    
    tS     = real(ifft(fullFFT(:, i), fftlength));
    
    start  = (i - 1)*hopsize + 1;
    finish = start + fftlength - 1;
    
        signal(start:finish) = signal(start:finish) + tS(:);

end
signal = signal(1:sigLen)*(hopsize/sum(window.^2));

end
