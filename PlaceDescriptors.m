function [frames, descriptors] = PlaceDescriptors(channel,label,epoch, psiftscale, psiftdescriptordensity, KS)

global DOTS;

verbose=GetParameter('verbose');

file = sprintf('e.%d.l.%d.c.%d.tif',epoch,label,channel);

if (verbose) fprintf ('Image File %s\n', file); end

I = imread(sprintf('%s%s',getimagepath(),file));
I = single(I);

%  VL SIFT
%edge_thresh = 10;

FC = [];
width=size(I,2);

% PARAMETROS IMPORTANTES
siftscale=psiftscale;
ssize=psiftdescriptordensity;

iterator=1;
keypoints=1;
i=1;
%KS
%DOTS(epoch,channel).YY

while (i<=size(DOTS(epoch,channel).YY,1))
    %if (DOTS(epoch,channel).YY(i)==30)

    % As long as the full descriptor fills within the available image
    % space....
    if ((DOTS(epoch,channel).YY(i)-siftscale*6)>0 &&  (DOTS(epoch,channel).YY(i)+siftscale*6)<=width) 

        % if some of the keypoints are located before the margins, skip
        % them
        while  (keypoints<(size(KS,2)) && ( KS(keypoints) < DOTS(epoch,channel).YY(i) ) )
            keypoints = keypoints + 1;
        end
        
        if (DOTS(epoch,channel).YY(i) == KS(keypoints))
            fc = [DOTS(epoch,channel).YY(i);DOTS(epoch,channel).XX(i);siftscale;0];

            %fc = [k;75;2;0];

            FC = [FC fc];
            iterator=ssize;  
            keypoints=keypoints+1;
        end

    end
    i=i+iterator;
    if (size(KS,2)<keypoints)
        break;
    end
end

if (size(FC,2)==0)
    sprintf('None of the provider positions has room for any descriptor  to fit inside completely inside the image from the desired position: %d', siftscale*6)
    error('error');
end

%[frames, descriptors] = vl_sift(I,'frames',FC,'floatdescriptors','verbose','verbose','verbose','verbose');
[frames, descriptors] = vl_sift(I,'frames',FC);
%[frames, descriptors] = vl_sift(I,'frames',FC,'verbose','verbose','verbose','verbose');


end




