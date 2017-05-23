function saveeegimage(epoch,label,channel,eegimg)
   
fprintf('Saving data to e.%d.l.%d.c.%d.tif \n',epoch,label,channel);
imwrite(eegimg,sprintf('%se.%d.l.%d.c.%d.tif',getimagepath(),epoch,label,channel),'Compression','none','Resolution',size(eegimg));      

end