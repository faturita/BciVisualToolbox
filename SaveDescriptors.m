%% Load Saved descriptors and frames for a given dataset.
%% 2 experiments, 14 channels, 10 Subjects.
function F = SaveDescriptors(labelRange,epochRange,channelRange, edge_thresh, psiftscale, psiftdescriptordensity, save)

fprintf('Saving Descriptors...\n');
    for epoch=epochRange
        for channel=channelRange
            label=labelRange(epoch);
            %F(channel,experiment,s).descriptors = dlmread(sprintf('%ssift.data.s.%d.e.%d.c.%d.descriptors.dat',getdatabasepath(),s,experiment,channel));
            %F(channel,experiment,s).frames = dlmread(sprintf('%ssift.data.s.%d.e.%d.c.%d.frames.dat',getdatabasepath(),s,experiment,channel));
            [frames, desc] = ConvertToDescriptor(channel,label,epoch,edge_thresh, psiftscale, psiftdescriptordensity);

            %if (save==1)
                %fprintf('%ssift.data.s.%d.e.%d.c.%d.frames.dat',getdatabasepath(),epoch,label,channel);
                dlmwrite(sprintf('%ssift.data.e.%d.l.%d.c.%d.descriptors.dat',getdescriptorpath(),epoch,label,channel), desc);
                dlmwrite(sprintf('%ssift.data.e.%d.l.%d.c.%d.frames.dat',getdescriptorpath(),epoch,label,channel), frames);
            %else
                %CheckDescriptors(subject,experiment,channel,desc);

                F(channel,label,epoch).descriptors = desc;
                F(channel,label,epoch).frames = frames;

                % esto esta al pedo total
                CheckDescriptors(epoch,label,channel,F(channel,label,epoch).descriptors);
            %end

        end
    end
end