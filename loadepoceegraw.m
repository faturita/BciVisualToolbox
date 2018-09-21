function output = loadepoceegraw(subject,file,dowemean)
 sprintf('%s%s%s%s',getdatapath(),filesep,subject,filesep,file )
fid = fopen( sprintf('%s%s%s%s',getdatapath(),filesep,subject,filesep,file ));

output_matrix = fscanf(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', [22 inf]);

fclose(fid);

output_matrix = output_matrix';
output = output_matrix(:,4:17);

if (dowemean == 1)
    %for i=1:14
    %        output(:,i) = output(:,i) - mean( output(:,i) );
    %end
    [n,m]=size(output);
    output=output - ones(n,1)*mean(output,1);
end