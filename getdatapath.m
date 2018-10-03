function basepath=getdatapath()

basepath = 'C:/Users/rramele/Google Drive/Data';
if exist(basepath,'dir')==0
    basepath = 'E:/Google Drive/Data';
    if exist(basepath,'dir')==0
        basepath = sprintf('%s/GoogleDrive/Data',getenv('HOME'));
        if (exist(basepath,'dir')==0)
            basepath = sprintf('%s/GoogleDrive/Data',getenv('HOMEPATH'));
        end
    end
end

end