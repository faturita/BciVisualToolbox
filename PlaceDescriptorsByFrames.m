function [frames, desc]  = PlaceDescriptorsByFrames(image, siftscale,qKS,distancetype);                

I = image;
I = single(I);

FC=[qKS(:,1) qKS(:,2) siftscale(1)+zeros(size(qKS,1),1) siftscale(2)+zeros(size(qKS,1),1) zeros(size(qKS,1),1)]';

size(FC)

[frames, desc] = vl_sift(I,'frames',FC,'floatdescriptors','octaves',1,'firstoctave',0);
desc = (desc/512.0)*1;

desc = 2 * desc - 1;
                
end