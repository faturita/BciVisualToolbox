function X = baselineremover(signal,start,windowsize,channelRange,downsize)

baseline = signal( start- floor(51/downsize):start+windowsize-1,:);

output = zeros(windowsize,size(channelRange,2));

pts=1:floor(51/downsize);

for channel=channelRange
   baseline(:,channel) = bf(baseline(:,channel),pts,'pchip');
   output(:,channel) = baseline(floor(51/downsize):floor(51/downsize)+windowsize-1,channel);
   %[n,m]=size(output);
   %output=output - ones(n,1)*mean(baseline(1:51-1,:),1);           
end
%figure;plot(output(:,2));

X = output;

end
