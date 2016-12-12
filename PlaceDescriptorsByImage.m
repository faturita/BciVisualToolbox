function [frames, descriptors] = PlaceDescriptorsByImage(image,DOTS,psiftscale, psiftdescriptordensity, KS)

verbose=GetParameter('verbose');

I = image;
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
while (i<=size(DOTS.XX,1))
    %if (DOTS(epoch,channel).YY(i)==30)

    if ((DOTS.YY(i)-siftscale*6)>0 &&  (DOTS.YY(i)+siftscale*6)<=width) 

        while ( KS(keypoints) < DOTS.YY(i) )
            keypoints = keypoints + 1;
        end
        
        if (DOTS.YY(i) == KS(keypoints))
            fc = [DOTS.YY(i);DOTS.XX(i);siftscale;0];

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




