function basepath=getdatasetpath()

basepath = 'C:/Users/rramele/Google Drive/BCI.Dataset';
if exist(basepath,'dir')==0
    basepath = 'E:/Google Drive/BCI.Dataset';
    if exist(basepath,'dir')==0
        basepath = sprintf('%s/GoogleDrive/BCI.Dataset',getenv('HOME'));
        if (exist(basepath,'dir')==0)
            basepath = sprintf('%s/GoogleDrive/BCI.Dataset',getenv('HOMEPATH'));
        end
    end
end

end