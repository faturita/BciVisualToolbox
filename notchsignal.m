function X=notchsignal(signal,channelRange,Fs)

X = zeros(size(signal,1),size(channelRange,1));
wo = 50/(Fs/2);  bw = wo/35;
[b,a] = iirnotch(wo,bw);

for channel=channelRange
   X(:,channel)=filter(b,a,signal(:,channel)); 
end


end