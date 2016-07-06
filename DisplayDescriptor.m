function descriptor = DisplayDescriptor(F,pivot,experiment,channel, descriptorId)

% Read Pivot Image
fprintf('s.%d.e.%d.c.%d.tif\n',pivot,experiment,channel);
I1 = imread(sprintf('%ss.%d.e.%d.c.%d.tif',getimagepath(),pivot,experiment,channel));
%img1=imtool(I1);

img1 = imshow(I1);

% Get Frames and Descriptors for pivot
frames1 = F(channel,experiment,pivot).frames;
descriptors1 = F(channel,experiment,pivot).descriptors;

% Choose one winner...
fprintf('Descriptor %d.%d.%d: %d\n', channel,experiment,pivot,descriptorId);
fprintf('Frame and Image patch:\n');

% (x,y,sigma, rotation).
frame = frames1(:,descriptorId);
frame = round(frame);
x1=frame(2)-8;
y1=frame(2)+8;
x2=frame(1)-8;
y2=frame(1)+8;

if (x1 < 1) x1 = 1;end
if (x2 < 1) x2 = 1;end


Ij = I1(x1:y1,x2:y2)


descriptor = descriptors1;


h1 = vl_plotframe(frame) ;
set(h1,'color','k','linewidth',3) ;

h3 = vl_plotsiftdescriptor(descriptor(:,descriptorId),frame) ;
set(h3,'color','g') ;

end