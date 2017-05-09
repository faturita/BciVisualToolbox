%%  EEG(single channel), image scale, F, epoch, label, channel, descriptorid
function descriptor = DisplayDescriptorImageByEEG(output,imagescale,F,epoch,label,channel, descriptorId, showpatch)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

[eegimg, DOTS] = eegimage(channel,output(:,channel),imagescale, false,false);

descriptor = DisplayDescriptorImageByImage(F(channel,label,epoch).frames,F(channel,label,epoch).descriptors,eegimg,descriptorId,showpatch);

end