function output = getdescriptorpath()

basepath = getdatabasepath();
   
output = sprintf('%s%s%s%s',basepath,filesep,'Descriptors',filesep );

end