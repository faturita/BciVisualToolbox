function X = extract(signal,start,length)

X = signal( start:start+length-1, :);

end