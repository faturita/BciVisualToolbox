clc
clear all
close all

Fs=256;
windowsize=1;
downsize=16;

subject=2;

%% copio parte de la fci?n loadEEG
load(sprintf('%s%s008-2014%sA%02d.mat',getdatasetpath(),filesep,filesep,subject))
% se?al cruda: en dataX guarda las se?ales
dataX = data.X;
datatrial=data.trial;
%extrae las se?ales de hits crudas
trial=1;
%{
% rango trial 1
ini=data.trial(1);
fin=data.trial(2)-1; ??? % es fin=ini+256*120-1
%}
% hit =  6    10 => nro de flashes para suj 2
vf=[6 10];
ch=2; %Cz
for i=1:2
    flash=vf(i);
    ini_f=data.trial(trial)+64*(flash-1);
    fin_f=ini_f+Fs*windowsize-1;
    epoch(i).label=data.y(data.trial(trial)+64*(flash-1));
    epoch(i).EEG=dataX(ini_f:fin_f,ch);
end

% dibujo se?ales crudas
l1='Sujeto 2';
l2=[' - trial ' num2str(trial)];
l3=[' - flash '];
l4=[' - ptp hits'];

s1=epoch(1).EEG;
s2=epoch(2).EEG;

nt=length(s1);
tt=linspace(0,1,nt);

figure(1)
subplot(2,1,1)
plot(tt,s1,'r-.','linewidth',2)
ylim([-25 25])
title([l1 l2 l3 num2str(vf(1))]);
subplot(2,1,2)
plot(tt,s2,'r-.','linewidth',2)
ylim([-25 25])
title([l1 l2 l3 num2str(vf(2))]);

%%%%%%%%%%%%%%%%%%%
%preprocesamiento
%%%%%%%%%%%%%%%%%%%
ws=(Fs/downsize)*windowsize;
for i=1:2
    sx(i).x=epoch(i).EEG;
    sx(i).x=notchsignal(sx(i).x,1);
    sx(i).x=bandpasseeg(sx(i).x,1,Fs);
    sx(i).x=decimatesignal(sx(i).x,1,downsize);
    %sx(i).x=baselineremover(sx(i).x,1,ws,ch,downsize); %l?o ?ndices
    % baselineremover a mano (restar la media)
    sx(i).x=sx(i).x-mean(sx(i).x);
    % estandarizaci?n
    sx(i).x=zscore(sx(i).x); % saqu? el *2
end

% dibujo se?ales preprocesadas
s1p=sx(1).x;
s2p=sx(2).x;

ntp=length(s1p);
ttp=linspace(0,1,ntp);

figure(2)
subplot(2,1,1)
plot(ttp,s1p,'r-.','linewidth',2)
ylim([-5 5])
title([l1 l2 l3 num2str(vf(1))]);
subplot(2,1,2)
plot(ttp,s2p,'r-.','linewidth',2)
ylim([-5 5])
title([l1 l2 l3 num2str(vf(2))]);

%%%%%%%%%%%%%%%%%%%%%%%
% usando smote
%%%%%%%%%%%%%%%%%%%%%%%
% se?ales crudas
original_mark=[1;1];
for j=1:Fs
    original_features=[epoch(1).EEG(j);epoch(2).EEG(j)];
    [final_features ~]=smote(original_features, original_mark);
    for k=1:length(final_features)
        epoch(2+k).EEG(j,1)=final_features(k);
    end
end

final_features


fdsfds
figure(3)
% curvas crudas
for k=1:2
    subplot(3,2,k)
    plot(1:Fs,epoch(k).EEG,'r-.','linewidth',2)
    xlim([0 257])
    title([l1 l2 l3 num2str(vf(k))]);
end
% sint?ticas
l5=' - sint?tica ';
for k=3:6
    subplot(3,2,k)
    plot(1:Fs,epoch(k).EEG,'b-.','linewidth',2)
    xlim([0 257])
    title([l1 l5 num2str(k-2)]);
end 

%preprocesamiento
for i=1:6
    sx(i).x=epoch(i).EEG;
    sx(i).x=notchsignal(sx(i).x,1);
    sx(i).x=bandpasseeg(sx(i).x,1,Fs);
    sx(i).x=decimatesignal(sx(i).x,1,downsize);
    %sx(i).x=baselineremover(sx(i).x,1,ws,ch,downsize); %l?o ?ndices
    % baselineremover a mano (restar la media)
    sx(i).x=sx(i).x-mean(sx(i).x);
    % estandarizaci?n
    sx(i).x=zscore(sx(i).x)*2;
end

figure(4)
lg=length(sx(1).x);
for k=1:2
    subplot(3,2,k)
    plot(1:lg,sx(k).x,'r-.','linewidth',2)
    xlim([0 lg+1]);
    ylim([-8 8]);
    title([l1 l2 l3 num2str(vf(k))]);
end
l5=' - sint?tica ';
for k=3:6
    subplot(3,2,k)
    plot(1:lg,sx(k).x,'b-.','linewidth',2)
    xlim([0 lg+1]);
    ylim([-8 8]);
    title([l1 l5 num2str(k-2)]);
end 

% promedio ptp
% originales
H2=[sx(1).x sx(2).x];
HM2=mean(H2,2);
l4=' - ptp hits ';
l6=' originales';
figure(5)
subplot(2,1,1)
plot(1:16,HM2,'r','linewidth',2)
ylim([-3 5])
title([l1 l2 l4 l6]);
% originales +  sint?ticas
l7=' con sint?ticas';
H6=[sx(1).x sx(2).x sx(3).x sx(4).x sx(5).x sx(6).x];
HM6=mean(H6,2);
subplot(2,1,2)
plot(1:16,HM6,'b','linewidth',2)
title([l1 l2 l4 l7]);
ylim([-3 5])