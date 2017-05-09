% Add salt-and-pepper noise to image.
function I = addsomenoise(image)

I = image;

d=2;
p0=0.1;

p1=0.9;

for i=1:size(I,1)
    for j=1:size(I,2)
        if ( rand < d )
            if ( rand <= p0)
                I(i,j) = 0;
            elseif (rand >= p1)
                I(i,j) = 255;
            end
        end
    end
end

end