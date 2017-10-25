function plotthiseeg(eeg,channels,channelRange,time1,time2,superposition)

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
hold on
% Create multiple lines using matrix input to plot
if (superposition)
    plot(eeg(:,:),'Parent',axes1);
else
    for c=channelRange
        plot(eeg(:,c)+c*100,'Parent',axes1);
    end
end
xlim(axes1,[time1 time2]);
%ylim(axes1,[-103.606833529613 119.258061149953]);
title(sprintf('Corte EEG de %10.5f a %10.5f',time1,time2));
ylabel('[microV]');
xlabel('[ms]');
legend(channels)
hold off


end