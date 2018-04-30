function [signal,shift]=pickmaskedsignal(sig,f,e,a)

signal = sig(f:e);

shift = a;

sa = a(f:e);

signal(sa==0) = [];

shift(a==0) = [];

end