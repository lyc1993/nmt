addpath('E:\Independent Study\Project')

cd 'E:\\Independent Study\\Project\\audioData\\en10000'

[data, Fs] = audioread('en0.wav');
new_data = resample(data,16000,Fs);

%sigLen = size of new_data%
[sigLen,n] = size(new_data);
[s,f,t] = spectrogram(new_data,320,160,512,16000);
abs_s = abs(s);
abs_s(abs_s==0) = 10000;

%calculate stft by using: stft = data^(i*e^(phase_data)) %
phase_data = angle(s);
stft = abs_s.*(exp(phase_data*i));

%function [signal] = overlapAndAdd(stft,sigLen,winlen,hopsize,fftlength)%
signal = overlapAndAdd(stft,sigLen,320,160,512);

cd 'E:\\Independent Study'
sname = 'new_en0_x.wav';
audiowrite(sname,signal,16000);

imagesc(t,f,20*log10(abs_s))
xlabel('Time (seconds)')
ylabel('Frequency (Hz)')
title('STFT ¨C Power Spectrum')
axis xy