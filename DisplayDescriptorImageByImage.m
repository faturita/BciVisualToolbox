%% Frames, is F(channel, label, epoch), epoch, label, channel, descriptorid
% if DescriptorId is zero, the patch is not shown. 
%
function descriptor = DisplayDescriptorImageByImage(frames,descriptors,image, descriptorId, showpatch)
%
% If descriptorId is equal to -1, it will show all the descriptors in only one figure
%

if (nargin<5)
    showpatch=0;
end

I1 = image;

if (size(descriptorId)>1)
    descriptorId = -1;
    descriptors=descriptors(:,descriptorId);
end

if (descriptorId > 0)
    % Choose one winner...
    fprintf('Descriptor Id: %d\n',descriptorId);
    fprintf('Frame and Image patch:\n');

    % (x,y,sigma, rotation).
    frame = frames(:,descriptorId);
    %frame = round(frame);
    S=floor(sqrt(2)*15/4);
    x1=ceil(frame(2)-frame(4)*S*4/2);
    y1=ceil(frame(2)+frame(4)*S*4/2);
    x2=ceil(frame(1)-frame(3)*S*4/2);
    y2=ceil(frame(1)+frame(3)*S*4/2);

    if (x1 < 1) x1 = 1;end
    if (x2 < 1) x2 = 1;end
    if (x2 > size(I1,1)) x2 = size(I1,1);end
    if (y2 > size(I1,2)) y2 = size(I1,2);end
    if (y1 > size(I1,1)) y1 = size(I1,1);end
    
    % Even if the patch is bigger I need to move one to fit the descriptor.
    Ij = I1(x1:y1,x2:y2);
    
    if (showpatch)
        imshow(Ij);
        %S = 12;
        frame(2) = (frame(4)*S*4)/2+1;  % +5
        frame(1) = (frame(3)*S*4)/2+1;
    else
        imshow(I1);
    end

    descriptor = descriptors;

    %h1 = vl_plotframe(frame) ;
    %set(h1,'color','k','linewidth',3) ;

    % The descriptor patch is a little bit smaller than how it is actually
    % is.
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
    % Show only the image without the descriptor.
    img1 = imshow(I1);
    descriptor = descriptors;
end

%reshape(descriptors, [8 16] );

end