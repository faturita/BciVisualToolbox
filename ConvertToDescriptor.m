function [frames, descriptors] = ConvertToDescriptor(channel,label,epoch,edge_thresh, psiftscale, psiftdescriptordensity)

global DOTS;

verbose=GetParameter('verbose');

file = sprintf('e.%d.l.%d.c.%d.tif',epoch,label,channel);

if (verbose) fprintf ('Image File %s\n', file); end

I = imread(sprintf('%s%s',getimagepath(),file));
%I= double(rgb2gray(I)/256);
I = single(I);

%  VL SIFT
%edge_thresh = 10;

if 1==2
    %[frames, descriptors] = vl_sift(I,'edgethresh', edge_thresh, 'Levels', 3,'Verbose','Verbose','Octaves', 1, 'FirstOctave',3);
    [frames, descriptors] = vl_sift(I,'edgethresh',edge_thresh);
    
    while ( size(descriptors,2) == 0 )
        edge_thresh = edge_thresh+1;
        %[frames, descriptors] = vl_sift(I,'edgethresh', edge_thresh, 'Levels', 3,'Verbose','Verbose','Octaves', 1, 'FirstOctave',3);
        [frames, descriptors] = vl_sift(I,'edgethresh',edge_thresh);
        
        
        if (edge_thresh > 100)
            error('There is no way to obtain valid thresholds from the given image.');
        end
    end
else

    FC = [];
    width=size(I,2);
    
    % PARAMETROS IMPORTANTES
    siftscale=psiftscale;
    ssize=psiftdescriptordensity;
    
    % if (width == 128)
    %     ssize = 12;
    %     siftscale=1;
    % elseif (width == 256 || width == 100)
    %     ssize = 24;
    %     siftscale=2;
    % end
    
    iterator=1;
    i=1;
    while (i<=size(DOTS(epoch,channel).XX,1))
        %if (DOTS(epoch,channel).YY(i)==30)
        
        if ((DOTS(epoch,channel).YY(i)-siftscale*6)>0 &&  (DOTS(epoch,channel).YY(i)+siftscale*6)<=width) 
        
            if (ssize>0)
                fc = [DOTS(epoch,channel).YY(i);DOTS(epoch,channel).XX(i);siftscale;0];

                %fc = [k;75;2;0];

                FC = [FC fc];
                iterator=ssize;
            
            else
                done=0;
                while (done==0)
                    where = randi(size(DOTS(epoch,channel).XX,1));
                    if ((DOTS(epoch,channel).YY(where)-siftscale*6)>0 &&  (DOTS(epoch,channel).YY(where)+siftscale*6)<=width) 
                        done=1;
                    end
                end
                fc = [DOTS(epoch,channel).YY(where);DOTS(epoch,channel).XX(i);siftscale;0];
                FC = [FC fc];
                break;                
            end
            
        end
        i=i+iterator;
        % Limit the number of descriptors generated.
        %if (size(FC,2)>=1)
        %    break;
        %end
    end
    
    
    %
    %     %for k=1+(128-ssize*10)/2+ssize/2:ssize:128-ssize/2
    %     for k=mod(width, ssize)/2+ssize/2:ssize:width-ssize/2
    %     %for k=1+8+12:24:256-12
    %         %fc = [k;output(k/2,channel)+75;2;0];
    %         L=I(:,k);
    %         y = find(L==255);
    %
    %         % Ojo que se pierde info, no es univoco por bresenham
    %         fc = [k;y(1);siftscale;0];
    %
    %         %fc = [k;75;2;0];
    %
    %         FC = [FC fc];
    %     end
    
    %[frames, descriptors] = vl_sift(I,'frames',FC,'floatdescriptors','verbose','verbose','verbose','verbose');
    [frames, descriptors] = vl_sift(I,'frames',FC);
    
    %[frames, descriptors] = vl_sift(I,'frames',FC,'verbose','verbose','verbose','verbose');
    
end


CheckDescriptors(epoch,label,channel,descriptors);

end




