%% If Signal(t,c) is greater than 70, on any channel, it is considered artifact.
function ret = isartifact(signal)

output = signal;

[n,m]=size(output);
output=output - ones(n,1)*mean(output,1);
              
iff = ((abs(output)>70));
ifs = find(sum(iff'>0));

ret = ~isempty(ifs);
            
end