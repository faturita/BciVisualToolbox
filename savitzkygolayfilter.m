function output = savitzkygolayfilter(output,channelRange)       

% Savitzky-Golay filtering
framelen=25; %debe ser un nro impar!!
order2=2;
for channel=channelRange
    output(:,channel)=sgolayfilt(output(:,channel),order2,framelen);
end
       
end