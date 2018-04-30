function sg = bounded(signal, min, max, val)

if (val<min || val>max)
    sg = 0;
else
    sg = signal(val);
end

end