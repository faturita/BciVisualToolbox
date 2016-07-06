function basepath=getimagepath()

basepath = 'C:\\Users\\rramele\\Desktop\\Data\\Plots\\';
if exist(basepath,'dir')==0
    basepath = 'C:\\Users\\User\\Desktop\\Data\\Plots\\';
    if exist(basepath,'dir')==0
        basepath = '/Users/rramele/Data/Plots/';
    end
end

end