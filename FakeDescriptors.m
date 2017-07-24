function F = FakeDescriptors(labelRange, epochRange, channelRange, length, confused)
% FakeDescriptors Creates a set of descriptor for the given parameter data.
% Parameters
noisesize=1;
sigma=30;
errorrate=1;
errorrate=0.00001;
dims = 2;
% =============================================


%a=exp( i * 2 * pi / 16 * 1 )

F1=FakeDescriptor([20;150],dims);
F2=FakeDescriptor([150;20],dims);

F3 =FakeDescriptor( [20;20], dims);
F4 =FakeDescriptor( [150;160], dims);

Basal=FakeDescriptor([100;100], dims);


%A = [ones(50,1);ones(50,1)+1];
%shuffle(A);

for channel=channelRange
    for epoch=epochRange
        SYNTHDESCRIPTORS=[];
        
        %z = (100+100i)+80* exp( i * 2 * pi / 16 * randi([1 16],1) );
        
        %x= real(z); y = imag(z);
        
        if (labelRange(epoch) == 1)
            if (rand > errorrate)
                SYNTHDESCRIPTORS = [SYNTHDESCRIPTORS F3+randi([-15 15],dims,1)];
            else
                SYNTHDESCRIPTORS = [SYNTHDESCRIPTORS F4+randi([-15 15],dims,1)];
            end
        else
            if (rand > errorrate)
                SYNTHDESCRIPTORS = [SYNTHDESCRIPTORS F1+randi([-15 15],dims,1)];
            else
                SYNTHDESCRIPTORS = [SYNTHDESCRIPTORS F2+randi([-15 15],dims,1)];
            end        
        end
        
        if (confused)
            for kj=1:noisesize
                SYNTHDESCRIPTORS = [SYNTHDESCRIPTORS Basal+randi([-sigma sigma],dims,1)];
            end
        end
        F(channel, labelRange(epoch), epoch).descriptors = SYNTHDESCRIPTORS;
        F(channel, labelRange(epoch), epoch).frames = [32; 76; 1.5; 3; 0];
    end
end

end