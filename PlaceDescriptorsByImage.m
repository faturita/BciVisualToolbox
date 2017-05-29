% Based on a given image, with input points DOTS, and SIFT scale psiftscale
% SIFT descriptors are placed according to KS.
%
% If KS is [], descriptors are located according to psiftdescriptordensity
% as long as they fit inside the available image space.
function [frames, descriptors] = PlaceDescriptorsByImage(image,DOTS,psiftscale, psiftdescriptordensity, KS, zerolevel)

if (nargin==5)
    zerolevel=0;
end

I = image;
I = single(I);

%  VL SIFT
%edge_thresh = 10;

FC = [];
width=size(I,2);

% PARAMETROS IMPORTANTES
siftscale=psiftscale(1);
ssize=psiftdescriptordensity;

iterator=1;
keypoints=1;
i=1;
while (i<=size(DOTS.XX,1))
    %if (DOTS(epoch,channel).YY(i)==30)

    if ((DOTS.YY(i)-siftscale*6)>0 &&  (DOTS.YY(i)+siftscale*6)<=width) 

        %while  (keypoints<(size(KS,2)) && ( KS(keypoints) < DOTS(epoch,channel).YY(i) ) )
        while ( KS(keypoints) < DOTS.YY(i) )
            keypoints = keypoints + 1;
        end
        
        if (DOTS.YY(i) == KS(keypoints))
            if (zerolevel==0)
                fc = [DOTS.YY(i);DOTS.XX(i);siftscale;psiftscale(2);0];
            else
                fc = [DOTS.YY(i);zerolevel;siftscale;psiftscale(2);0];
            end
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
[frames, descriptors] = vl_sift(I,'frames',FC); % , 'orientations');
%[frames, descriptors] = vl_sift(I,'frames',FC,'verbose','verbose','verbose','verbose','octaves',1,'firstoctave',0);
%[frames, descriptors] = vl_sift(I,'frames',FC,'octaves',1,'firstoctave',0);

%descriptors = vl_hog(I,8);
%descriptors = reshape(descriptors, [1 31*size(descriptors,1)*size(descriptors,2)] );
%frames = FC;

%[frames, descriptors] = vl_sift(I,'verbose',  'verbose','verbose','verbose','octaves',1,'firstoctave',1,'edgethresh',10);


end




