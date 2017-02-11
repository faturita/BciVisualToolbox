function P = decimateaveraging(signal,channelRange, averagingsize)

P = zeros(size(signal,1)/averagingsize,size(channelRange,2));
for channel=channelRange
    P(:,channel) = (mean(reshape(signal(:,channel),averagingsize,[])))';
end

end