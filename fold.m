function folds = fold( k, indexRange )
%folds k-fold partition an Index Vector.
%   Useme only for equal-length partitions to avoid statistical problems.

mi = floor(size(indexRange,2) / k);

perms=randperm(size(indexRange,2));

shuffledIndexRange=indexRange(perms);
%shuffledIndexRange=shuffle(indexRange);

folds = cell(1,k);
for l = 1:k
   remains = l*mi;
   if (remains > size(indexRange,2))
       remains = size(indexRange,2);
   end
   folds{l} = shuffledIndexRange((l-1)*mi+1:remains);
end

end

