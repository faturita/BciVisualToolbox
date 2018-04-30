% This function converts the matrix signal output, for the specified
% channel into a binary image @ image.  The scale value can be used to 
% precisely set the scale, which at the same time plays the role of
% adjusting the resolution (because the output matrix is decimal rounded).
%
% Scale can be used to adjust the amplitud scale of the signal to image
% transform.  
% Timescale adjust the scale on the time axis.
%
% The drawzerolevel parameters can be specified if you want to have a line
% located at the temporal media of the signal (useful for debugging).
function [image, DOTS, zerolevel, height] = eegimageinvariant(channel,output,scale,timescale, drawzerolevel,defaultheight)

verbose=0;
DEFAULTHEIGHT = defaultheight;
BUFFERSIZE = 12/2;

timespan = size(output,1);

% Invert signal so that the image will be exactly as the source signal.
output = output * (-1);

if (nargin<4)
    drawzerolevel=0;
    DEFAULTHEIGHT=256;
end

% mean(output(:,channel) is zero).  After round it WONT be zero anymore.
signal = round(output(:,channel)*scale);

% 6 is half the size of single scale descriptor.
baseheight = (max(signal) - min(signal))+BUFFERSIZE

% The minimum height is 150 (nothing is more arbitrary than this).
if (baseheight < DEFAULTHEIGHT)
    baseheight = DEFAULTHEIGHT;
end

zerolevel= floor(baseheight/2) - floor((max(signal)+min(signal))/2);
if (timespan ~= 64 && timespan ~= 16 && timespan ~= 21 && timespan ~= 160 && timespan ~= 50 && timespan ~= 128 && timespan ~=32 && timespan ~=1280 && timespan ~=512 && timespan ~= 256 && timespan ~= 240)
    %error('Not enough data points!!!');
end

if (zerolevel < baseheight/2)
    temp=ceil(baseheight/2)-zerolevel;
    zerolevel=ceil(baseheight/2);
    height = baseheight + temp; 
else
    height = baseheight + 2 * zerolevel - baseheight;
end

%height = baseheight;

timespan = timespan * timescale;

% Zeros(h, size);
B = zeros(height,timespan);

if (verbose) fprintf('Signal Amplitude %f\n', floor( max(signal) - min(signal) ));end
if (verbose) fprintf('Generating image size: %f, %f\n', timespan, height);end
if (verbose) fprintf ('Zero level: %d\n', zerolevel);end

plottedsignal = zeros(timespan,1);

% Plot the original dots from the signal forming an image.
for t=1:timescale:timespan
    % REVISAR BIEN  mod estar?a demas
    plottedsignal(t) = (signal(floor(t/timescale)+mod(1,timescale))+zerolevel);
    
    % Basic outliers rejection.
    if (plottedsignal(t)> height)
        plottedsignal(t)
        height
        zerolevel
        plottedsignal(t) = height-1;
        
        error('The signal went out of boundaries.');
    end
    if (plottedsignal(t)< 1)
        plottedsignal(t)
        plottedsignal(t) = 1;
        
        error('The signal went bellow lower boundary.');
    end
    
    if (drawzerolevel == 1)
        B(zerolevel,t) = 255;
    end
    B(plottedsignal(t),t) = 255;
end
%figure('PaperPositionMode','manual');

% Dots holds all the sample points locations in 2d.
DOTS.XX = [];
DOTS.YY = [];

% Fill in discrete interpolation using bresenham
for t=1:timescale:(timespan-timescale)
    [Y X]=bresenham(t,plottedsignal(t), t+timescale,plottedsignal(t+timescale));
    
    DOTS.XX = [DOTS.XX; X];
    DOTS.YY = [DOTS.YY; Y];
    
    for i=1:size(X,1)
        B(X(i),Y(i)) = 255;
    end
end


% Uncomment to show the image with the dots.
%img=imshow(B);

%B = flipud(B);

%B = vl_imsmooth(B,0.2);

%imwrite(rgb2gray(imread('C:\Users\User\Desktop\shoes.bmp')), 'C:\Users\User\Desktop\shoes.bmp');

% Do a final check
s=[height timespan];

if ( s(1)  ~= size(B,1) || s(2) ~= size(B,2) )
    size(B)
    s
    error('Image dimension rearranged due to outliers...');
end
image = B;

end