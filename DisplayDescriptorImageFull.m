%%  F, epoch, label, channel, descriptorid
function descriptor = DisplayDescriptorImageFull(F,subject,epoch,label,channel, descriptorId, showpatch)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

descriptor = DisplayDescriptorImage(F(channel, label, epoch).frames, F(channel, label, epoch).descriptors, subject,epoch, label, channel, descriptorId,showpatch);


end