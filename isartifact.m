function ret = isartifact(signal)

iff = ((abs(signal)>70));
ifs = find(iff==1);
ret = (size(ifs,1)>1);  
            
end