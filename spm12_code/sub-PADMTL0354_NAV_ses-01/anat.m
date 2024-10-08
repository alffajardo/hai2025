
% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:}); 
quit
