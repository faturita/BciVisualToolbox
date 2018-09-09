function X = bandpasseeg(signal, channelRange, Fs, Wn,delaymax)

if (nargin<4)
    Wn=4;
end

if (nargin<5)
    delaymax = false;
end

% Band pass filter.  Originally it was 4,5/ (Fs/2) )
[b,a] = butter(4,Wn/(Fs/2));

%x1 = 10*sin(2*pi*10*t) + signal ;

gr = grpdelay(b,a,Fs);   % plot group delay

if (delaymax)
    D = max(gr); % filter delay in samples
else
    D = mean(gr);
end
D = floor(D);

X = zeros(size(signal,1),size(channelRange,1));

for channel=channelRange

   %freqz(b,a)
   x1 = signal(:,channel);
   %data.X(:,channel) = filter(b,a,x1);
   
   x1  = filter(b,a,[x1; zeros(D,1)]);% Append D zeros to the input data
   X(:,channel)  = x1(D+1:end); % Shift data to compensate for delay
   
   
end

end