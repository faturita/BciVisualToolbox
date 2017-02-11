function indexRange = defold( folds, f )
%defold k-fold defolding to build up a training index vector.
%   f should be the test fold, which will be excluded.

indexRange=[];

for k=1:size(folds,2)
    
    if (k~=f)
        indexRange = [indexRange folds{k}];
    end

end

end

