function X = baselineremover(signal,start,windowsize,channelRange,downsize)
        
baseline = signal( start- floor(51/downsize):start-1,:);

%baseline = zeros( size( start- floor(51/downsize):start-1,2),size(channelRange,2));
windowsize = ceil(windowsize);

output = zeros(windowsize,size(channelRange,2));

pts=1:floor(51/downsize);

[n,m]=size(output);

%for channel=channelRange
   %baseline(:,channel) = bf(baseline(:,channel),pts,'pchip');
   %output(:,channel) = baseline(floor(51/downsize):floor(51/downsize)+windowsize-1,channel);
   output=signal( start:start+windowsize-1,:) - ones(n,1)*mean(baseline,1);           
%end
%figure;plot(output(:,2));

X = output;

end
