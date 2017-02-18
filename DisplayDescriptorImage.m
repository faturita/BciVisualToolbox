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

if (size(descriptorId)>1)
    descriptorId = -1;
    descriptors=descriptors(:,descriptorId);
end

if (descriptorId > 0)
    % Choose one winner...
    fprintf('Descriptor %d.%d.%d: %d\n', epoch,label,channel,descriptorId);
    fprintf('Frame and Image patch:\n');

    % (x,y,sigma, rotation).
    frame = frames(:,descriptorId);
    frame = round(frame);
    x1=frame(2)-frame(3)*6;
    y1=frame(2)+frame(3)*6;
    x2=frame(1)-frame(3)*6;
    y2=frame(1)+frame(3)*6;

    if (x1 < 1) x1 = 1;end
    if (x2 < 1) x2 = 1;end
    
    % Even if the patch is bigger I need to move one to fit the descriptor.
    Ij = I1(x1:y1,x2:y2);
    
    if (showpatch)
        imshow(Ij);
        frame(2) = (frame(3)*12)/2+1;
        frame(1) = (frame(3)*12)/2+1;
    else
        imshow(I1);
    end

    descriptor = descriptors;

    %h1 = vl_plotframe(frame) ;
    %set(h1,'color','k','linewidth',3) ;

    h3 = vl_plotsiftdescriptor(descriptors(:,descriptorId),frame) ;
    set(h3,'color','g') ;
elseif (descriptorId <0)
    img1 = imshow(I1);
    h1 = vl_plotframe(frames) ;
    set(h1,'color','k','linewidth',3) ;

    h3 = vl_plotsiftdescriptor(descriptors,frames) ;
    set(h3,'color','g') ;    
    
    descriptor = descriptors(:,1);
else
    img1 = imshow(I1);
    descriptor = descriptors;
end

end