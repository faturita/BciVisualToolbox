%% Converts the signal for the subject,experiment,channel stored in output into a saved image.
%% If the signal amplitud is less than 150, it is defaulted to 150.
function image = eegimagesaved(epoch,label,output,channel,scale, drawzerolevel)

global DOTS;

[image, DOTS] = eegimage(channel,output,scale, drawzerolevel);


if (true)
    fprintf('Saving data to e.%d.l.%d.c.%d.tif \n',epoch,label,channel);
    imwrite(B,sprintf('%se.%d.l.%d.c.%d.tif',getimagepath(),epoch,label,channel),'Compression','none','Resolution',[timespan height]);
    %imwrite(B,sprintf('%se.%d.l.%d.c.%d.png',getimagepath(),epoch,label,channel));
end

%imwrite(rgb2gray(imread('C:\Users\User\Desktop\shoes.bmp')), 'C:\Users\User\Desktop\shoes.bmp');
end