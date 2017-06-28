function saveeegimage(epoch,label,channel,eegimg)

verbose = 0;

if (verbose) fprintf('Saving data to e.%d.l.%d.c.%d.tif \n',epoch,label,channel);end
imwrite(eegimg,sprintf('%se.%d.l.%d.c.%d.tif',getimagepath(),epoch,label,channel),'Compression','none','Resolution',size(eegimg));      

end