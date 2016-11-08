

Fs = 256;                    % Sampling frequency (EPOC frequency)
T = 1/Fs;                     % Sample time
L = 256;                    % Length of signal
t = (0:L-1)*T;                % Time vector

signal = FakeNoisyEeg(8,1:1,256);
signal = signal(:,1)';


d = fdesign.bandstop('Fp1,Fst1,Fst2,Fp2,Ap1,Ast,Ap2',7,9,11,13,0.5,50,0.5,Fs);
% view filter's magnitude response
Hd = design(d);
%fvtool(Hd)
% filter you data



x1 = 10*sin(2*pi*10*t) + signal ;

gr = grpdelay(Hd,Fs);   % plot group delay
D = mean(gr); % filter delay in samples
                 
output = filter(Hd,[(x1'); zeros(D,1)]);% Append D zeros to the input data
output = output(D+1:end); % Shift data to compensate for delay

figure;plot(signal);
figure;plot(x1);
figure;plot(output);

