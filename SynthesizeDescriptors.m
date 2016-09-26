function F = SynthesizeDescriptors(F, labelRange, epochRange, channelRange, length)

for epoch=epochRange
    for channel=channelRange
        label=labelRange(epoch);
        %F(channel,label,epoch).descriptors = [ sum(F(channel,label,epoch).descriptors,2)];
        d=F(channel,label,epoch).descriptors;
        for i=1:128
            dd(i,:) = fliplr(conv(fliplr(d(i,:)),[zeros(1,length) ones(1,length)],'same'));            
            %dd = dd(i,1:length);
        end
        F(channel,label,epoch).descriptors = dd(:,1:length);
        F(channel,label,epoch).oframes = F(channel,label,epoch).frames;
        F(channel,label,epoch).frames = [];
        F(channel,label,epoch).frames = F(channel,label,epoch).oframes(:,1:length);
    end
end

end