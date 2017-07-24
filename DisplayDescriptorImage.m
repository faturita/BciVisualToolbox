%% Frames, is F(channel, label, epoch), epoch, label, channel, descriptorid
function descriptor = DisplayDescriptorImage(frames,descriptors,subject,epoch,label,channel, descriptorId, showpatch)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

if (nargin<7)
    showpatch=0;
end

% Read Pivot Image
fprintf('s.%d.e.%d.l.%d.c.%d.tif\n',subject,epoch,label,channel);
I1 = imread(sprintf('%ss.%d.e.%d.l.%d.c.%d.tif',getimagepath(),subject,epoch,label,channel));
%img1=imtool(I1);
%figure;
fprintf('Image Size: %d,%d \n',size(I1,1),size(I1,2));

descriptor = DisplayDescriptorImageByImage(frames,descriptors,I1,descriptorId,showpatch);

end