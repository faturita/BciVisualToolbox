function F = SynthesizeDescriptors(F, labelRange, epochRange, channelRange)

for epoch=epochRange
    for channel=channelRange
        label=labelRange(epoch);
        F(channel,label,epoch).descriptors = [ sum(F(channel,label,epoch).descriptors,2)];
    end
end

end