function basepath=getdatabasepath()

basepath = sprintf('%s%s%s%s%s%s',getenv('HOME'),filesep,'Desktop',filesep,'Data',filesep);
if exist(basepath,'dir')==0
    basepath = 'C:/Users/User/Desktop/Data';
    if exist(basepath,'dir')==0
        basepath = sprintf('%s%s%s%s',getenv('HOME'),filesep,'Data',filesep);
    end
end

end