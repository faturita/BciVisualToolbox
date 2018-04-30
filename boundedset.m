function signal = boundedset(signal, min, max, pos,val)

if (pos>=min && pos<=max)
    signal(pos) = val;
end

end