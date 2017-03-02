function noisyoutput = drugsignal(Fs,signal,amp,drougfreq)
% Fs,signal,amp,drougFreq

T = 1/Fs;                     % Sample time
L = size(signal,1);                     % Length of signal
t = (0:L-1)*T;                % Time vector

t = repmat(t,size(signal,2),1)';
%amp=10;
noisyoutput = signal+(amp*sin(2*pi*drougfreq*t));

end