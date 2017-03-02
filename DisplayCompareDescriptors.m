function DisplayCompareDescriptors(data,F,channelRange,Fs,windowsize,downsize,siftscale,epoch1,label1,channel1,epoch2,label2,channel2,KS)

%% Data Visualization
figure;
subplot(2,2,1);
epoch=epoch1;

output = baselineremover(data.X,data.epoch(epoch),Fs*windowsize,channelRange,downsize);
plot((-1)*output(:,channel1));
axis([0 Fs -30 30]);
% Add lines
h1 = line([ceil(KS/4 + siftscale*12/4) ceil(KS/4 + siftscale*12/4)],[-30 30]);
h2 = line([floor(KS/4) floor(KS/4)],[-30 30]);
% Add a patch
gray = [0.4 0.4 0.4];
patch([ceil(KS/4 + siftscale*12/4) floor(KS/4) floor(KS/4) ceil(KS/4 + siftscale*12/4)],[-30 -30 30 30],gray)
set(gca,'children',flipud(get(gca,'children')))
% Set properties of lines
set([h1 h2],'Color','k','LineWidth',2)

subplot(2,2,3);
DisplayDescriptorImageFull(F,epoch,label1,channel1,1,true);

subplot(2,2,2);
epoch=epoch2;
output = baselineremover(data.X,data.epoch(epoch),Fs*windowsize,channelRange,downsize);
plot((-1)*output(:,channel2));axis([0 256/downsize -30 30]);
h1 = line([ceil(KS/4 + siftscale*12/4) ceil(KS/4 + siftscale*12/4)],[-30 30]);
h2 = line([floor(KS/4) floor(KS/4)],[-30 30]);
% Add a patch
gray = [0.4 0.4 0.4];
patch([ceil(KS/4 + siftscale*12/4) floor(KS/4) floor(KS/4) ceil(KS/4 + siftscale*12/4)],[-30 -30 30 30],gray)
set(gca,'children',flipud(get(gca,'children')))
subplot(2,2,4);
DisplayDescriptorImageFull(F,epoch,label2,channel2,1,true);
%print(fa,'sampledescriptor','-dpng')

end