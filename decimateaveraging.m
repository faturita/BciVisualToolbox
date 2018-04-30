function P = decimateaveraging(signal,channelRange, averagingsize)

%signal=zeros(1,256);
%Fs=256;

%channelRange=1:1;
%T = 1/Fs;                     % Sample time
%L = size(signal,2);                     % Length of signal
%t = (0:L-1)*T;                % Time vector

%x1 = sin(2*pi*10*t) ;
%averagingsize=16;

%signal=x1';

% Get an integer number of samples.
signal = signal(1:floor(size(signal,1)/averagingsize)*averagingsize,:);


P = zeros(size(signal,1)/averagingsize,size(channelRange,2));
for channel=channelRange
    % For each channel, the signal is divided in chunks of
    % size(signal,1)/averagingsize and they are averaged together.
    segmentedsignal=reshape(signal(:,channel),[averagingsize size(signal,1)/averagingsize]);
    P(:,channel) = (mean(segmentedsignal,1));
end

end