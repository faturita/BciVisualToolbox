function X = addextrasignal()

T = 1/256;                     % Sample time
L = size(data.X,1);                     % Length of signal
t = (0:L-1)*T;                % Time vector

% I add a 50 Hz TRASH signal to understand if the FFT is working.
X = (10*sin(2*pi*10*t))' + data.X(:,2) ;


end