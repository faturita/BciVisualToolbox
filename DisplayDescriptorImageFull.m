%%  F, epoch, label, channel, descriptorid
function descriptor = DisplayDescriptorImageFull(F,epoch,label,channel, descriptorId)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

descriptor = DisplayDescriptorImage(F(channel, label, epoch).frames, F(channel, label, epoch).descriptors, epoch, label, channel, descriptorId);


end