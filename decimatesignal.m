function P = decimatesignal(signal,channelRange,downsize)

for channel=channelRange
    P(:,channel) = decimate(signal(:,channel),downsize,'fir')';
end



end