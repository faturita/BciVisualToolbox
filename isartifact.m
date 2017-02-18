%% If Signal(t,c) is greater than 70, on any channel, it is considered artifact.
function ret = isartifact(signal)  

[n,m]=size(signal);
signal=signal - ones(n,1)*mean(signal,1);

iff = ((abs(signal)>70));

ifs = find(sum(iff'>0));

ret = ~isempty(ifs);

end
