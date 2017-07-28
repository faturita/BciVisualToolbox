% Save Experiment
dirorigin=sprintf('%s%s%s',getdatabasepath(),filesep,'Plots');
dirtarget=sprintf('%s%s%s',getdatabasepath(),filesep,sprintf('%d',expcode));


copyfile(dirorigin,dirtarget);
save(sprintf('Experiment.%d',expcode));
