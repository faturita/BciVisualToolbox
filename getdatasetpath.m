function basepath=getdatasetpath()

basepath = 'C:/Users/rramele/Google Drive/BCI.Dataset';
if exist(basepath,'dir')==0
    basepath = 'C:/Users/User/Google Drive/BCI.Dataset';
    if exist(basepath,'dir')==0
        basepath = sprintf('%s/GoogleDrive/BCI.Dataset',getenv('HOME'));
    end
end

end