% https://www.mathworks.com/help/signal/examples/measuring-signal-similarities.html

Fs=256;

signal= fakep300(1, 1,1:1,Fs);   

T = 1/Fs;                     % Sample time
L = size(signal,2);                     % Length of signal
t = (0:L-1)*T;                % Time vector

% I add a 50 Hz TRASH signal to understand if the FFT is working.
x1 = 10.7*sin(2*pi*20*t) + signal ;

figure(1);plot(x1);

figure(2);drawfft(x1',true,Fs);

[b,a] = butter(4,9/(Fs/2));

%x1 = 10*sin(2*pi*10*t) + signal ;

gr = grpdelay(b,a,Fs);   % plot group delay
D = mean(gr); % filter delay in samples
D = floor(D);

 
x1  = filter(b,a,[x1; zeros(D,1)]);% Append D zeros to the input data
x2  = x1(D+1:end); % Shift data to compensate for delay
  

   
figure(3);plot(x2);

figure(4);drawfft(x2', true, Fs);


fdsfdsfs
















% Load data
load relatedsig.mat

figure
ax(1) = subplot(3,1,1);
plot((0:numel(T1)-1)/Fs1,T1,'k')
ylabel('Template 1')
grid on
ax(2) = subplot(3,1,2);
plot((0:numel(T2)-1)/Fs2,T2,'r')
ylabel('Template 2')
grid on
ax(3) = subplot(3,1,3);
plot((0:numel(S)-1)/Fs,S)
ylabel('Signal')
grid on 
xlabel('Time (secs)')
linkaxes(ax(1:3),'x')
axis([0 1.61 -4 4])


fprintf ('Sampling rates are differents...')

[Fs1 Fs2 Fs]

fprintf ('So the first thing to do is to downsample the one with larger Fs')

[P1,Q1] = rat(Fs/Fs1);          % Rational fraction approximation
[P2,Q2] = rat(Fs/Fs2);          % Rational fraction approximation
T1 = resample(T1,P1,Q1);        % Change sampling rate by rational factor
T2 = resample(T2,P2,Q2);        % Change sampling rate by rational factor

fprintf ('Rational returns the rational division (integer division with non positive remainder).\n')
fprintf ('Now template signals share the same Fs than the query signal.\n')


[C1,lag1] = xcorr(T1,S);
[C2,lag2] = xcorr(T2,S);

figure
ax(1) = subplot(2,1,1);
plot(lag1/Fs,C1,'k')
ylabel('Amplitude')
grid on
title('Cross-correlation between Template 1 and Signal')
ax(2) = subplot(2,1,2);
plot(lag2/Fs,C2,'r')
ylabel('Amplitude')
grid on
title('Cross-correlation between Template 2 and Signal')
xlabel('Time(secs)')
axis(ax(1:2),[-1.5 1.5 -700 700 ])


fprintf ('What is the lagging between the signal and the Template 2\n')

[~,I] = max(abs(C2));
SampleDiff = lag2(I);
timeDiff = SampleDiff/Fs;

fprintf ('In sample points, sampleDiff %d, in sample points is the lag\n', SampleDiff);


fprintf ('Three similar signals missaligned\n')
figure,
ax(1) = subplot(3,1,1);
plot(s1)
ylabel('s1')
grid on
ax(2) = subplot(3,1,2);
plot(s2,'k')
ylabel('s2')
grid on
ax(3) = subplot(3,1,3);
plot(s3,'r')
ylabel('s3')
grid on
xlabel('Samples')
linkaxes(ax,'xy')

t21 = finddelay(s1,s2)
t31 = finddelay(s1,s3)


s1 = alignsignals(s1,s3);
s2 = alignsignals(s2,s3);

figure
ax(1) = subplot(3,1,1);
plot(s1)
grid on
title('s1')
axis tight
ax(2) = subplot(3,1,2);
plot(s2)
grid on
title('s2')
axis tight
ax(3) = subplot(3,1,3);
plot(s3)
grid on
title('s3')
axis tight
linkaxes(ax,'xy')




Fs = FsSig;         % Sampling Rate

[P1,f1] = periodogram(sig1,[],[],Fs,'power');
[P2,f2] = periodogram(sig2,[],[],Fs,'power');

figure
t = (0:numel(sig1)-1)/Fs;
subplot(2,2,1)
plot(t,sig1,'k')
ylabel('s1')
grid on
title('Time Series')
subplot(2,2,3)
plot(t,sig2)
ylabel('s2')
grid on
xlabel('Time (secs)')
subplot(2,2,2)
plot(f1,P1,'k')
ylabel('P1')
grid on
axis tight
title('Power Spectrum')
subplot(2,2,4)
plot(f2,P2)
ylabel('P2')
grid on
axis tight
xlabel('Frequency (Hz)')


fprintf ('Check spectral coherence, to verify if there are certain shared freq components\n')

[Cxy,f] = mscohere(sig1,sig2,[],[],[],Fs);
Pxy     = cpsd(sig1,sig2,[],[],[],Fs);
phase   = -angle(Pxy)/pi*180;
[pks,locs] = findpeaks(Cxy,'MinPeakHeight',0.75);

figure
subplot(2,1,1)
plot(f,Cxy)
title('Coherence Estimate')
grid on
hgca = gca;
hgca.XTick = f(locs);
hgca.YTick = 0.75;
axis([0 200 0 1])
subplot(2,1,2)
plot(f,phase)
title('Cross-spectrum Phase (deg)')
grid on
hgca = gca;
hgca.XTick = f(locs);
hgca.YTick = round(phase(locs));
xlabel('Frequency (Hz)')
axis([0 200 -180 180])


fprintf ('Las señales tienen dos componentes pero que cada uno de ellos difiere en la fase (cuando uno sube el otro baja).  Esto es importante para entender bien que representa la fase.\n')
fprintf ('The phase lag between the 35 Hz components is close to -90 degrees, and the phase lag between the 165 Hz components is close to -60 degrees.')




% Load Temperature Data
load officetemp.mat
Fs = 1/(60*30);                 % Sample rate is 1 sample every 30 minutes
days = (0:length(temp)-1)/(Fs*60*60*24);

figure
plot(days,temp)
title('Temperature Data')
xlabel('Time (days)')
ylabel('Temperature (Fahrenheit)')
grid on


maxlags = numel(temp)*0.5;
[xc,lag] = xcov(temp,maxlags);

[~,df] = findpeaks(xc,'MinPeakDistance',5*2*24);
[~,mf] = findpeaks(xc);

figure
plot(lag/(2*24),xc,'k',...
     lag(df)/(2*24),xc(df),'kv','MarkerFaceColor','r')
grid on
xlim([-15 15])
xlabel('Time (days)')
title('Auto-covariance')



fprintf ('Ahora a chequear los picos obtenidos para ver si hay algún patrón de periodicidad....');
cycle1 = diff(df)/(2*24);
cycle2 = diff(mf)/(2*24);

subplot(2,1,1)
plot(cycle1)
ylabel('Days')
grid on
title('Dominant peak distance')
subplot(2,1,2)
plot(cycle2,'r')
ylabel('Days')
grid on
title('Minor peak distance')

mean(cycle1)
mean(cycle2)

