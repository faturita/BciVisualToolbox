% First clean up everything so that we can reload a new
% fresh version of mex files and dynamic libraries for vlfeat.

% Use me if you want to check the capacity of the SIFT descriptor to
% capture what is going on on the underlying signal.

clear mex
clc
clear
clearvars
close all

% Restart vl-feat
run('/Users/rramele/work/vlfeat/toolbox/vl_setup')


% General parameters
gamma = 1;
% Scales
sv=5;
st=3;
siftdescriptordensity=1;

% Hidden parameters
% Smooth on first octave
% Orientation
% Fixed Octave, Number of octaves


% Dataset parameters
label=1;
channel=1;

subject=1;trial=10;downsize=1;flash=1;Fs=256;windowsize=1;channelRange=1:8;
load(sprintf('/Users/rramele/GoogleDrive/BCI.Dataset/008-2014/A%02d.mat',subject));

output = baselineremover(data.X,(ceil(data.trial(trial)/downsize)+ceil(64/downsize)*flash),Fs*windowsize,channelRange,downsize);

% Just pick one channel.
output=output(:,1)*1;

output = decimate(output,16);

% Pick random EEG
%output = fakeeegoutput(gamma, 1:8,label,16)*6;

% Pick a dead signal.
%output = zeros(256,1);

t = (-1:0.01:1)';

impulse = t==0;
unitstep = t>=0;
ramp = t.*unitstep;
quad = t.^2.*unitstep;


%%

routput = floor(output*10);
size(unique(routput))

max(routput)-min(routput)

gamma=10;

% Transform the signal into a new fresh images and gather all the 
% 2-d datapoints.
[patternimage, patternDOTS, zerolevel] = eegimage(channel,output,gamma,false);


%patternimage = addsomenoise(patternimage);

%patternimage = imread('sample.jpg');
%patternimage = rgb2gray(patternimage);

%patternimage = zeros(150,256);

% Add some random extra lines.
for i=63:67
    %patternimage(i,180) = 255;
end

for i=1:256
    %patternimage(65,i) = 255;
end


qKS = 32;
[patternframes, descriptors] = PlaceDescriptorsByImage(patternimage, patternDOTS,[st sv], siftdescriptordensity,qKS,zerolevel,true);

figure;DisplayDescriptorImageByImage(patternframes,descriptors,patternimage,1,false);

%descriptors = single(descriptors);

% Pick only one descriptor for following analysis.
descriptors = descriptors(:,1);

% Display Descriptor Values
reshape(descriptors, [8 16] )


%I = A(:,3)';
%I = reshape(I,size(patternimage));
%imshow(I)

figure;DisplayDescriptorGradient('baseimageonscale.txt');

figure;[I,A] = DisplayDescriptorGradient('grads.txt');

figure;
DisplayDescriptorImageByImageAndGradient(patternframes,descriptors,patternimage,1,A);

