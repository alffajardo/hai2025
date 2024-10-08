% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/pet_preproc_template_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
