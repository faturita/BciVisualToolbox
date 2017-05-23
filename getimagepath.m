function basepath=getimagepath()
        
basepath = sprintf('%s%s%s%s%s%s%s%s',getenv('HOME'),filesep,'Desktop',filesep,'Data',filesep,'Plots',filesep);
if exist(basepath,'dir')==0
    basepath = 'C:\\Users\\User\\Desktop\\Data\\Plots\\';
    if exist(basepath,'dir')==0
        basepath = sprintf('%s%s%s%s%s%s',getenv('HOME'),filesep,'Data',filesep,'Plots',filesep);
    end
end

end