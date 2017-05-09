% First clean up everything so that we can reload a new
% fresh version of mex files and dynamic libraries for vlfeat.

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
sv=4;
st=11;
siftdescriptordensity=1;

% Dataset parameters
label=1;
channel=1;

subject=1;trial=10;downsize=1;flash=1;Fs=256;windowsize=1;channelRange=1:8;
load(sprintf('/Users/rramele/GoogleDrive/BCI.Dataset/008-2014/A%02d.mat',subject));

output = baselineremover(data.X,(ceil(data.trial(trial)/downsize)+ceil(64/downsize)*flash),Fs*windowsize,channelRange,downsize);

% Just pick one channel.
output=output(:,1);

% Pick random EEG
%output = fakeeegoutput(gamma, 1:8,label,512);

% Pick a dead signal.
%output = zeros(256,1);

% Transform the signal into a new fresh images and gather all the 
% 2-d datapoints.
[patternimage, patternDOTS] = eegimage(channel,output,gamma,false);

%patternimage = addsomenoise(patternimage);

%patternimage = imread('sample.jpg');
%patternimage = rgb2gray(patternimage);

% Add some random extra lines.
for i=1:150
    %patternimage(150/2-2,i+150) = 255;
    %patternimage(150/2+2,i+150) = 255;
    %patternimage(i,256) = 255;
end



qKS = 128;
[patternframes, descriptors] = PlaceDescriptorsByImage(patternimage, patternDOTS,[st sv], siftdescriptordensity,qKS);

figure;DisplayDescriptorImageByImage(patternframes,descriptors,patternimage,1);

%descriptors = single(descriptors);

% Pick only one descriptor for following analysis.
descriptors = descriptors(:,1);

% Display Descriptor Values
reshape(descriptors, [8 16] );


%I = A(:,3)';
%I = reshape(I,size(patternimage));
%imshow(I)

figure;[I,A] = DisplayDescriptorGradient();

figure;
DisplayDescriptorImageByImageAndGradient(patternframes,descriptors,patternimage,1,A);

