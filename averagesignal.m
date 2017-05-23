function [rmean, bmean] = averagesignal(Fs, routput, boutput, show)

channelRange = (1:size(routput,2));
channelsize = size(channelRange,2);

routput=reshape(routput,[Fs size(routput,1)/Fs channelsize]);
boutput=reshape(boutput,[Fs size(boutput,1)/Fs channelsize]);

for channel=channelRange
    rmean(:,channel) = mean(routput(:,:,channel),2);
    bmean(:,channel) = mean(boutput(:,:,channel),2);

    rcov(:,channel) = var(routput(:,:,channel),0,2);
    bcov(:,channel) = var(boutput(:,:,channel),0,2);

    rstd(:,channel) = std(routput(:,:,channel),0,2);
    bstd(:,channel) = std(boutput(:,:,channel),0,2);
    
    ra(:,channel) = max(routput(:,:,channel),[],2);
    rb(:,channel) = min(routput(:,:,channel),[],2);

    ba(:,channel) = max(boutput(:,:,channel),[],2);
    bb(:,channel) = min(boutput(:,:,channel),[],2);    
    
    rbi(:,channel) = rmean(:,channel) - 2.*rstd(:,channel)/sqrt((size(routput,2)));  
    rbs(:,channel) = rmean(:,channel) + 2.*rstd(:,channel)/sqrt((size(routput,2)));
    bbi(:,channel) = bmean(:,channel) - 2.*bstd(:,channel)/sqrt((size(boutput,2)));
    bbs(:,channel) = bmean(:,channel) + 2.*bstd(:,channel)/sqrt((size(boutput,2)));


    n=size(routput,2);
    alfa=0.05;
    a=1-alfa/2;

    bn=n/(n-8);

  
    rmadu(:,channel) = rmean(:,channel) + 1.253 * tinv(a,n-1) * bn * J_mad(routput(:,:,channel),1,2);
    rmadl(:,channel) = rmean(:,channel) - 1.253 * tinv(a,n-1) * bn * J_mad(routput(:,:,channel),1,2);
        
    
    bmadu(:,channel) = bmean(:,channel) + 1.253 * tinv(a,n-1) * bn * J_mad(boutput(:,:,channel),1,2);
    bmadl(:,channel) = bmean(:,channel) - 1.253 * tinv(a,n-1) * bn * J_mad(boutput(:,:,channel),1,2);
           
    bmad(:,channel) = J_mad(boutput(:,:,channel),1,2);
    
    rmad(:,channel) = J_mad(routput(:,:,channel),1,2);
    
    
end


if (show)
    figure;

    ch = 2;

    subplot(5,1,1);
    hold on
    %plot(rmean(:,ch),'r');
    %plot(rbi(:,ch),'r');
    %plot(rbs(:,ch),'r');

    plot(rmean(:,ch),'r');
    plot(ra(:,ch),'r');
    plot(rb(:,ch),'r');

    for i=1:size(routput,2)
        plot(routput(:,i,2),'g-')
    end
    title('Mean vs min max for hit');
    axis([0 Fs -25 25]);
    subplot(5,1,2);
    hold on;
    %plot(bmean(:,ch),'b');
    %plot(bbi(:,ch),'b');
    %plot(bbs(:,ch),'b');

    plot(bmean(:,ch),'b');
    plot(ba(:,ch),'b');
    plot(bb(:,ch),'b');

    for i=1:size(boutput,2)
        plot(boutput(:,i,2),'g-')
    end

    title('Mean vs min max for nohit');
    axis([0 Fs -25 25]);
    subplot(5,1,3);
    hold on;
    plot(bcov(:,ch),'b');
    plot(rcov(:,ch),'r');
    title('Variance for hit and nohit');
    axis([0 Fs -25 25]);
    subplot(5,1,4);
    hold on;
    plot(rmean(:,ch),'r');
    plot(rmadu(:,ch),'g');
    plot(rmadl(:,ch),'g');
    %plot(bmean(:,ch),'b');
    title('Mean values');
    axis([0 Fs -25 25]);
    
    subplot(5,1,5);
    plot(bmad(:,ch),'r');
    plot(rmad(:,ch),'b'); 
    title('MAD values');
    axis([0 Fs -25 25]);    
    
    hold off
end

end