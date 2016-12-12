function [ R ] = zeropaddedimage( I,rangei,rangej )

R = zeros(size(rangei,2),size(rangej,2));


for i=1:size(rangei,2)
    for j=1:size(rangej,2)
        if (rangei(i) < 1 || rangei(i) > size(I,1))
            R(i,j) = 0;
        elseif (rangej(j) < 1 || rangej(j) > size(I,2))
            R(i,j) = 0;
        else
            R(i,j) = I(rangei(i),rangej(j));
        end
    end
end

end

