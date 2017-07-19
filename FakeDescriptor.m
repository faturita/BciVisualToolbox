function [ D ] = FakeDescriptor( point, dims )
%FakeDescriptor Creates a descriptor based on points of dims size.
%   Creates a feature of size dims.
D=[];
for i=1:2:dims-2
    %D=[ D; randi([-15+120 15+120],2,1) ];
    D=[ D; point ];
end

D=[D ; point];

end

