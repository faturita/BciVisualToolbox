function output = loadepoceeg(subject,file,dowemean)

filepath = '/Users/rramele/Google Drive/Emotiv/%s/%s';
%filepath = 'C:\\Users\\User\\Desktop\\Emotiv\\%s\\%s';


output = dlmread( sprintf(filepath,subject,file ) );

if (dowemean == 1)
    %for i=1:14
    %        output(:,i) = output(:,i) - mean( output(:,i) );
    %end
    [n,m]=size(output);
    output=output - ones(n,1)*mean(output,1);
end