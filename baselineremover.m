function X = baselineremover(signal,start,end)

baseline = data.X( (data.trial(trial)+64*flash)-51:(data.trial(trial)+64*flash)+Fs*length-1,:);
         
        for channel=channelRange
           baseline(:,channel) = bf(baseline(:,channel),1:51,'pchip');
           %output(:,channel) = baseline(51:51+256-1,channel);
           %[n,m]=size(output);
           %output=output - ones(n,1)*mean(baseline(1:51-1,:),1);           
        end
        %figure;plot(output(:,2));

end
