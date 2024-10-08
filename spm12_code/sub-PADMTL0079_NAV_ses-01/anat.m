
% List of open inputs
nrun = 1; % enter the number of runs here
<<<<<<<< HEAD:spm12_code/sub-PADMTL0079_NAV_ses-01/anat.m
jobfile = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025_neur608/spm12_code/sub-PADMTL0079_NAV_ses-01/anat_job.m'};
========
jobfile = {'$PWD/struct_template_job.m'};
>>>>>>>> 0e47869497fd1220bc946815b07a9d3d02fce29c:spm12_code/struct_template.m
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
<<<<<<<< HEAD:spm12_code/sub-PADMTL0079_NAV_ses-01/anat.m
spm_jobman('run', jobs, inputs{:}); 
========
spm_jobman('run', jobs, inputs{:});
>>>>>>>> 0e47869497fd1220bc946815b07a9d3d02fce29c:spm12_code/struct_template.m
quit
