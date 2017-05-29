function [rmean, bmean] = multichannelaveragesignal(Fs, routput, boutput, show)

channelRange = (1:size(routput,2));
channelsize = size(channelRange,2);

routput=reshape(routput,[Fs size(routput,1)/Fs channelsize]);
boutput=reshape(boutput,[Fs size(boutput,1)/Fs channelsize]);

rmean = mean(routput,3);
rmean = mean(rmean,2);

bmean = mean(boutput,3);
bmean = mean(bmean,2);

end