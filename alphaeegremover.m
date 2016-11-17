function output = alphaeegremover(samplefreq,channel,signal)

Fs = samplefreq;              % Sampling frequency (EPOC frequency)
T = 1/Fs;                     % Sample time
L = size(signal,1)  ;          % Length of signal
t = (0:L-1)*T;                % Time vector

signal = signal(:,channel)';


%d = fdesign.bandstop('Fp1,Fst1,Fst2,Fp2,Ap1,Ast,Ap2',0.1,0.2,10,12,0.5,50,0.5,Fs);
d = fdesign.lowpass('Fp,Fst,Ap,Ast',10,11,10,0.1,Fs);
%d = fdesign.lowpass('N,Fc',10,10,Fs);

% view filter's magnitude response
Hd = design(d);
%fvtool(Hd)
% filter you data

%x1 = 10*sin(2*pi*10*t) + signal ;

x1=signal;

gr = grpdelay(Hd,Fs);   % plot group delay
D = mean(gr); % filter delay in samples
D = floor(D);

output = filter(Hd,[(x1'); zeros(D,1)]);% Append D zeros to the input data
output = output(D+1:end); % Shift data to compensate for delay

end