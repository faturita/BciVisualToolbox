epochRange=1:420;
trainingRange=1:180;
testRange=180+1:420;

graphics = true;

labelRange=[ones(1,150+200) ones(1,30+40)+1];
rp = randperm(size(labelRange,2), size(labelRange,2));

% Permute labels.
labelRange=labelRange(rp);

channelRange=1:8;

F = FakeDescriptors(labelRange,epochRange,channelRange,2,false);

channel=1;

[M, IX] = BuildDescriptorMatrix(F,channel,labelRange,trainingRange);
fprintf('Descriptor Matrix Size:%d\n', size(M,2)); 


[TM, TIX] = BuildDescriptorMatrix(F,channel,labelRange,testRange);
fprintf('Descriptor Matrix Size:%d\n', size(TM,2)); 

if (graphics)
    for i=1:size(M',1)
        KL=M';
        if (IX(i,2) == 1)
            line(KL(i,1),KL(i,2),'marker','X','color','b',...
                'markersize',10,'linewidth',2,'linestyle','none');
        elseif (IX(i,2) == 2)
            line(KL(i,1),KL(i,2),'marker','X','color','r',...
                'markersize',10,'linewidth',2,'linestyle','none');
        end
    end
end



%%
% https://github.com/rishirdua/linear-separability-matlab

%set max iteration
maxiter = 100000;

%load data
%[Ytrain, Xtrain] = libsvmread('sample.txt'); %libsvm format

% m x 1 
%Ytrain = labelRange(epochRange)';
Ytrain=IX(:,2);
Ytrain(find(Ytrain==2)) = -1;

% m x n, 180 x 128
Xtrain = M';


mtrain = size(Xtrain,1);
n = size(Xtrain,2);


% learn perceptron
Xtrain_perceptron = [ones(mtrain,1) Xtrain];
alpha = 0.1;
%initialize
theta_perceptron = zeros(n+1,1);
trainerror_mag = 10000;
iteration = 0;

%loop
while (trainerror_mag>0)
	iteration = iteration+1;
	if (iteration == maxiter)
		break;
	end;
	for i = 1 : mtrain
		Ypredict_temp = sign(theta_perceptron'*Xtrain_perceptron(i,:)');
		theta_perceptron = theta_perceptron + alpha*(Ytrain(i)-Ypredict_temp)*Xtrain_perceptron(i,:)';
	end
	Ytrainpredict_perceptron = sign(theta_perceptron'*Xtrain_perceptron')';
	trainerror_mag = (Ytrainpredict_perceptron - Ytrain)'*(Ytrainpredict_perceptron - Ytrain);
end

if (trainerror_mag==0)
	fprintf('Data is Linearly seperable\n'); 
	fprintf('Parameters are:\n'); 
	disp(theta_perceptron)
else
	fprintf('Data is not linearly seperable\n');
end;


%%
dsize= size(M,1);

A = M;
A(dsize+1,:) = 0;

lbs= IX(:,2);
A(:,find(lbs==2)) = -1*A(:,find(lbs==2));
A(dsize+1,find(lbs==2)) = 1;
A(:,find(lbs==1)) = 1*A(:,find(lbs==1));
A(dsize+1,find(lbs==1)) = -1;

A=double(A);
b = -1*ones(1,size(A,2));

f = zeros(size(A,1),1);

% f'*x such that A*x <= b
x = linprog(f,A',b')

%%
% SVM
% Row observation, column feature

% https://www.mathworks.com/help/stats/svmtrain.html

%'method'
% Method used to find the separating hyperplane. Options are:
% 'QP' ? Quadratic programming (requires an Optimization Toolbox? license). The classifier is a 2-norm soft-margin support vector machine. Give quadratic programming options with the options name-value pair, and create options with optimset.
% 'SMO' ? Sequential Minimal Optimization. Give SMO options with the options name-value pair, and create options with statset.
% 'LS' ? Least squares.

lbs= IX(:,2);
H = double(M);

svmStruct = svmtrain(H',lbs,'ShowPlot',true,'kernel_function','linear'); %, 'method','QP');


group = svmclassify(svmStruct,H');


% First lets find where is the difference.
diffs = lbs-group;

disp('Ids en donde pifio la auto clasificacion con SVM:');

% IDs has the id list to testRange where the classification failed.
IDs = find(diffs~=0)


%%
%predicted = classify(TM',M',labelRange(trainingRange),'linear'); 
net = feedforwardnet([64]);
net.trainParam.showWindow=0;
net.layers{1}.transferFcn = 'logsig';
net = train(net, M, lbs');

outputs = net( TM );

predicted = round(outputs);

% First lets find where is the difference.
diffs = TIX(:,2)'-predicted;

disp('Ids en donde pifio la generalizaci?n con FF NNet:');

% IDs has the id list to testRange where the classification failed.
IDs = find(diffs~=0)
