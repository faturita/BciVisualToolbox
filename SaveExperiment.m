% Save Experiment
exp=1;

dirorigin=sprintf('%s%s%s',getdatabasepath(),filesep,'Plots');
dirtarget=sprintf('%s%s%s',getdatabasepath(),filesep,sprintf('%d',exp));


copyfile(dirorigin,dirtarget);
save(sprintf('Experiment.%d',exp));
