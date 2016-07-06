% Load Saved descriptors and frames for a given dataset.
function F = LoadDescriptors(labelRange,epochRange,channelRange)

fprintf('Loading cached data...\n');
for epoch=epochRange
    for channel=channelRange
        label=labelRange(epoch);
        %fprintf('%ssift.data.s.%d.e.%d.c.%d.descriptors.dat\n',getdatabasepath(),epoch,label,channel)

        F(channel,label,epoch).descriptors = dlmread(sprintf('%ssift.data.e.%d.l.%d.c.%d.descriptors.dat',getdescriptorpath(),epoch,label,channel));
        F(channel,label,epoch).frames = dlmread(sprintf('%ssift.data.e.%d.l.%d.c.%d.frames.dat',getdescriptorpath(),epoch,label,channel));

        CheckDescriptors(epoch,label,channel,F(channel,label,epoch).descriptors);
    end
end

end