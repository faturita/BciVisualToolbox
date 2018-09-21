% Use this function to upsample the signal to timescale.
function [rput2,output] = upinterpolate(input, timescale, channelRange)

L = size(input,1);

% This fixes the issue of chirps at the endpoints.
rput1 = [input; input; input];

rput2 = zeros(L*3*timescale,size(channelRange,2));

for c=channelRange

    rput2(:,c) = resample(rput1(:,c),1:size(rput1,1),timescale);

end

output = rput2(L*timescale:L*timescale+L*timescale-1,:);

assert( size(output,1) == (size(input,1)*timescale), 'Interpolation Error: Signals size should match');

end