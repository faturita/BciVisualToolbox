function b = rzscore(signal)
b = zeros(size(signal,1),size(signal,2));

    for i=1:size(signal,2)
        b(:,i) = ( signal(:,i) - median(signal(:,i)) ) / J_mad(signal(:,i),1,1);
    end
end