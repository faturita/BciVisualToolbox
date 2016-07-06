function basepath=getdatabasepath()

basepath = 'C:/Users/rramele/Desktop/Data';
if exist(basepath,'dir')==0
    basepath = 'C:/Users/User/Desktop/Data';
    if exist(basepath,'dir')==0
        basepath = '/Users/rramele/Data';
    end
end

end