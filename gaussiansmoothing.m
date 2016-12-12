function [ I ] = gaussiansmoothing( I, s )
% GaussianSmoothing
%
%   s    Size of window (sigma will be s/3)
%   I    Image
%

siggma = s/3.0;

if (s>0)
    % Gaussian Smoothing
    adjusted = median(1:s);

    for i=1:s
        for j=1:s
            Kernel(i,j) = (1.0/(2 * pi * siggma^2)) * exp(- (((i-adjusted)^2 + (j-adjusted)^2)/(siggma^2) ));
        end
    end


    for i=1:size(I,1)
        for j=1:size(I,2)
            Patch = zeropaddedimage(I,i-adjusted+1:i+adjusted-1,j-adjusted+1:j+adjusted-1);
            I(i,j) = dot(Kernel(:),Patch(:)) / sum(sum(abs(Kernel(:))));
        end
    end

    % La salida de dot es muy sucia.
    I = double(uint8(I));
end

end

