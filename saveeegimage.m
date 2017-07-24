function saveeegimage(subject,epoch,label,channel,eegimg)

verbose = 0;

if (verbose) fprintf('Saving data to s.%d.e.%d.l.%d.c.%d.tif \n',subject,epoch,label,channel);end
imwrite(eegimg,sprintf('%ss.%d.e.%d.l.%d.c.%d.tif',getimagepath(),subject,epoch,label,channel),'Compression','none','Resolution',size(eegimg));      

end