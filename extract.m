function X = extract(signal,start,windowsize)

[start start+windowsize-1]
X = signal( start:start+windowsize-1, :);


%for channel=channelRange
%x2(:,channel) = decimate(data.X(:,channel), 8);
%end
%data.X=x2;

end