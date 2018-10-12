function powerspectraldensity = drawfft(signal, drawme, Fs,addfiftyhertz)
% PSD = drawfft(signal, darwme, Fs)
%
% signal is output(t,channel)'
%
if (nargin<3)
    Fs = 128;                    % Sampling frequency (EPOC frequency)
end

if (nargin<4)
    addfiftyhertz=false;
end

T = 1/Fs;                     % Sample time
L = size(signal,2);                     % Length of signal
t = (0:L-1)*T;                % Time vector

% I add a 50 Hz TRASH signal to understand if the FFT is working.

if (addfiftyhertz)
    x1 = 0.5*sin(2*pi*50*t) + signal ;
else
    x1 = signal;
end

%h = fdesign.bandpass('Fp,Fst,Ap,Ast',9,11,0.5,70,128);

%h = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', 6/65,8/65,12/65,14/65,60,1,60);
%d = design(h,'butter');
%x1 = filter(d,x1);


NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(x1,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

if (drawme == 1)
    % Plot single-sided amplitude spectrum.
    %figure;
    plot(f,2*abs(Y(1:NFFT/2+1))) ;
    %axis([6 14 -0.2 2.5]);
    %axis([0 60 -0.2 0.6]);
    %axis([0 60 -0.2 0.5]);
    hy = ylabel('|Y(f)|');
    hx = xlabel('Frequency (Hz)');
    set(hx,'fontSize',20);
    set(hy,'fontSize',20);
end

powerspectraldensity = mean ( ( 2*abs(Y(1:NFFT/2+1)) ) ); 
disp ( powerspectraldensity );


end
