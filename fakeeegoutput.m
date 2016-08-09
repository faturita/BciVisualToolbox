function output = fakeeegoutput(imagescale, class, channelRange,nSampleFreq)

% Ru?do uniforme con varianza 2.
output = rand(nSampleFreq,size(channelRange,2))*0;
%output = FakeNoisyEeg(14,nSampleFreq);
    
Fs = nSampleFreq;             % Sampling frequency (EPOC frequency)
T = 1/Fs;                     % Sample time
L = size(output,1);           % Length of signal
t = (0:L-1)*T;                % Time vector

%x1 = sin(2*pi*40*(1:4000)/1000);

if (class == 1)
    % I add a 50 Hz TRASH signal to understand if the FFT is working.
    for ch=channelRange
        output(:,ch) = (4.0*sin(2*pi*16*t)') + output(:,ch) ;
    end
elseif (class == 2)
    for ch=channelRange
        output(:,ch) = (8.0*sin(2*pi*16*t)') + output(:,ch) ;
    end
end


% if (class == 1 || class == 28)
%     for ik=50:55
%         output(ik,:)=val;
%         val=val+abs(0.5)*2;
%     end
%     for ik=55:60
%         output(ik,:)=val;
%         val=val-abs(0.5)*3;
%     end
% elseif (class == 2)
%     for ik=50:55
%         output(ik,:)=val;
%         val=val-abs(0.5)*2;
%     end
%     for ik=55:60
%         output(ik,:)=val;
%         val=val+abs(0.5)*2;
%     end
% end

end
