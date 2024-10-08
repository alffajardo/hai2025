% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/pet_preproc_template_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});

%% Calculate SUVr in template space

% Read the whole cerebellum mask
WC_mask_hdr = spm_vol('/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/template_spm12/voi_WhlCbl_2mm_spm12.nii');
WC_mask_img = spm_read_vols(WC_mask_hdr);

% Now we read the PET image
pet_hdr = spm_vol('/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/pet2tpl_fwhm_04mm_pet2tpl_masked.nii');
pet_img = spm_read_vols(pet_hdr);

% Calculate the mean SUV in the cerebellum mask
mean_WC = mean(pet_img(WC_mask_img ~= 0));

% Divide the PET image by the recently calculated mean
pet_suvr_hdr = pet_hdr;
pet_suvr_hdr.fname = '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070_space-tpl_fwhm_04mm_suvr.nii';
pet_suvr_img = pet_img / mean_WC;

spm_write_vol(pet_suvr_hdr,pet_suvr_img);
clear all
%% Calculate SUVr in anat space

% Read the whole cerebellum mask
WC_mask_hdr = spm_vol('/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/tpl2anat_WCmask_bin.nii');
WC_mask_img = spm_read_vols(WC_mask_hdr);

% Read the pet file 
pet_hdr = spm_vol('/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/resampled_2mmfwhm_4mm_masked_meanpetvol.nii');
pet_img = spm_read_vols(pet_hdr);

% Calculate the mean SUV in the Cerebellum mask
mean_WC = mean(pet_img(WC_mask_img ~=0)) ; 

pet_suvr_hdr= pet_hdr ; 
pet_suvr_hdr.fname = '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070_space-anat_fwhm_04mm_suvr.nii' ;

pet_suvr_img = pet_img / mean_WC ;

spm_write_vol(pet_suvr_hdr,pet_suvr_img);

%%