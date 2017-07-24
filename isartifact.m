%% If Signal(t,c) is greater than 70, on any channel, it is considered artifact.
function ret = isartifact(signal,threshold)  

[n,m]=size(signal);
signal=signal - ones(n,1)*mean(signal,1);

iff = ((abs(signal)>threshold));

ifs = find(sum(iff'>0));

ret = ~isempty(ifs);

end
