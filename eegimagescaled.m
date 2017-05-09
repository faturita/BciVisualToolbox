%% Converts the signal for the subject,experiment,channel stored in output into a saved image.
%% If the signal amplitud is less than 150, it is defaulted to 150.
function image = eegimagescaled(epoch,label,output,channel,scale, siftinterpolated, drawzerolevel,save)
timespan = size(output,1);

if (nargin<8)
    save=1;
    drawzerolevel=0;
elseif (nargin<7)
    drawzerolevel=0;
end

error ('DO NOT USE ME');

ALL = 1;
global DOTS;

% mean(output(:,channel) is zero).  After round it WONT be zero anymore.
signal = round(output(:,channel)*scale);

% 6 is half the size of single scale descriptor.
baseheight = (max(signal) - min(signal))+6;

% The minimum height is 150
if (baseheight < 150)
    baseheight = 150;
end

zerolevel= floor(baseheight/2) - floor((max(signal)+min(signal))/2);
if (timespan ~= 16 && timespan ~= 21 && timespan ~= 160 && timespan ~= 50 && timespan ~= 128 && timespan ~=32 && timespan ~=1280 && timespan ~=512 && timespan ~= 256 && timespan ~= 240 && timespan ~= 64)
    timespan
    error('Not enough data points!!!');
else
    %baseheight = rms(output,1)*4;
end

height = baseheight;

timespan = timespan * scale;

% Zeros(h, size);
B = zeros(height,timespan);

fprintf('Signal Amplitude %f\n', floor( max(signal) - min(signal) ));
fprintf('Generating image size: %f, %f\n', timespan, height);
fprintf ('Zero level: %d\n', zerolevel);

plottedsignal = zeros(timespan);

% Timespan est? tambi?n escalado.
for t=1:scale:timespan
    % REVISAR BIEN  mod estar?a demas
    plottedsignal(t) = (signal(floor(t/scale)+mod(1,scale))+zerolevel);
    
    % Basic outliers rejection.NO DEBERIA PASAR
    if (plottedsignal(t)> height)
        plottedsignal(t)
        plottedsignal(t) = height-1;
        
        error('NOOOOO');
    end
    if (plottedsignal(t)< 1)
        plottedsignal(t)
        plottedsignal(t) = 1;
        
        error('NOOOOOOO');
    end
    
    if (drawzerolevel == 1)
        B(zerolevel,t) = 255;
    end
    B(plottedsignal(t),t) = 255;
end
%figure('PaperPositionMode','manual');

DOTS(epoch,channel).XX = [];
DOTS(epoch,channel).YY = [];

for t=1:scale:(timespan-scale)
    [Y X]=bresenham(t,plottedsignal(t), t+scale,plottedsignal(t+scale));
    
    %if (siftinterpolated == 1)
        DOTS(epoch,channel).XX = [DOTS(epoch,channel).XX; X];
        DOTS(epoch,channel).YY = [DOTS(epoch,channel).YY; Y];
    %else
    %    DOTS(epoch,channel).XX = [DOTS(epoch,channel).XX; plottedsignal(t)];
    %    DOTS(epoch,channel).YY = [DOTS(epoch,channel).YY; t];
    %send
    
    for i=1:size(X,1)
        B(X(i),Y(i)) = 255;
    end
end


% Uncomment to show the image with the dots.
%img=imshow(B);

%B = flipud(B);

%B = vl_imsmooth(B,0.2);

if (save)
    fprintf('Saving data to e.%d.l.%d.c.%d.tif \n',epoch,label,channel);
    imwrite(B,sprintf('%se.%d.l.%d.c.%d.tif',getimagepath(),epoch,label,channel),'Compression','none','Resolution',[timespan height]);
    %imwrite(B,sprintf('%se.%d.l.%d.c.%d.png',getimagepath(),epoch,label,channel));
end

%imwrite(rgb2gray(imread('C:\Users\User\Desktop\shoes.bmp')), 'C:\Users\User\Desktop\shoes.bmp');

s=[height timespan];

if ( s(1)  ~= size(B,1) || s(2) ~= size(B,2) )
    size(B)
    s
    error('Image dimension rearranged due to outliers...');
end
image = B;