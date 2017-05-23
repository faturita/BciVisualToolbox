%% Load Saved descriptors and frames for a given dataset.
%% 2 experiments, 14 channels, 10 Subjects.
function F = SaveDescriptors(labelRange,epochRange,channelRange, edge_thresh, psiftscale, psiftdescriptordensity, KS)

fprintf('Saving Descriptors...\n');
for epoch=epochRange
    for channel=channelRange
        label=labelRange(epoch);
        %F(channel,experiment,s).descriptors = dlmread(sprintf('%ssift.data.s.%d.e.%d.c.%d.descriptors.dat',getdatabasepath(),s,experiment,channel));
        %F(channel,experiment,s).frames = dlmread(sprintf('%ssift.data.s.%d.e.%d.c.%d.frames.dat',getdatabasepath(),s,experiment,channel));
        if (size(KS,2) == 0)
           [frames, desc] = ConvertToDescriptor(channel,label,epoch, edge_thresh, psiftscale, psiftdescriptordensity);
        else
           [frames, desc] = PlaceDescriptors(channel,label,epoch, psiftscale, psiftdescriptordensity,KS);
        end

        dlmwrite(sprintf('%ssift.data.e.%d.l.%d.c.%d.descriptors.dat',getdescriptorpath(),epoch,label,channel), desc);
        dlmwrite(sprintf('%ssift.data.e.%d.l.%d.c.%d.frames.dat',getdescriptorpath(),epoch,label,channel), frames);


        F(channel,label,epoch).descriptors = desc;
        F(channel,label,epoch).frames = frames;

        CheckDescriptors(epoch,label,channel,F(channel,label,epoch).descriptors);

    end
end
end