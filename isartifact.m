%% If Signal(t,c) is greater than 70, it is considered artifact.
function ret = isartifact(signal)

iff = ((abs(signal)>70));
ifs = find(sum(iff'>0));

ret = ~isempty(ifs);
            
end