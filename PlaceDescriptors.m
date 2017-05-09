% Get the DOTS global function with the values of the signals for the whole
% dataset.
function [frames, descriptors] = PlaceDescriptors(channel,label,epoch, psiftscale, psiftdescriptordensity, KS)

global DOTS;

verbose=GetParameter('verbose');

file = sprintf('e.%d.l.%d.c.%d.tif',epoch,label,channel);

if (verbose) fprintf ('Image File %s\n', file); end

I = imread(sprintf('%s%s',getimagepath(),file));
I = single(I);

[frames, descriptors] = PlaceDescriptorsByImage(I,DOTS(epoch,channel),psiftscale, psiftdescriptordensity, KS);

end




