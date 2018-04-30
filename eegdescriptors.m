
minimagesize=1;
i=1;
[eegimg, DOTS, zerolevel, height] = eegimage(channel,rsignal{i},imagescale,1, false,minimagesize);

saveeegimage(subject,epoch,label,channel,eegimg);
zerolevel = size(eegimg,1)/2;

%             if ((size(find(trainingRange==epoch),2)==0))
%                qKS=ceil(0.20*(Fs)*timescale):floor(0.20*(Fs)*timescale+(Fs)*timescale/4-1);
%             else
    qKS=sqKS(subject);
    qKS=125;
%             end

siftscale(1) = 11.7851;
siftscale(2) = (height-1)/(sqrt(2)*15);

[frames, desc] = PlaceDescriptorsByImage(eegimg, DOTS,siftscale, siftdescriptordensity,qKS,zerolevel,false,distancetype);            
F(channel,label,epoch).stim = i;
F(channel,label,epoch).hit = hit{subject}{trial}{i};


F(channel,label,epoch).descriptors = desc;
F(channel,label,epoch).frames = frames; 
            
plot(rsignal{i})
imshow(eegimg)
DisplayDescriptorImageFull(F,subject,epoch,label,channel,-1,true);