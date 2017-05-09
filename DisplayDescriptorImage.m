%% Frames, is F(channel, label, epoch), epoch, label, channel, descriptorid
function descriptor = DisplayDescriptorImage(frames,descriptors,epoch,label,channel, descriptorId, showpatch)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

if (nargin<7)
    showpatch=0;
end

% Read Pivot Image
fprintf('e.%d.l.%d.c.%d.tif\n',epoch,label,channel);
I1 = imread(sprintf('%se.%d.l.%d.c.%d.tif',getimagepath(),epoch,label,channel));
%img1=imtool(I1);
%figure;


descriptor = DisplayDescriptorImageByImage(frames,descriptors,I1,descriptorId,showpatch);

end