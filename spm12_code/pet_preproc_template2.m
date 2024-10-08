% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/pet_preproc_template_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});

%% Calculate SUVr

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
pet_suvr_hdr.fname = '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/pet2tpl_fwhm_04mm_pet2tpl_masked_suvr.nii';
pet_suvr_img = pet_img / mean_WC;

% Write the NIfTI file with the SUVr
spm_write_vol(pet_suvr_hdr, pet_suvr_img);

%% Now we will resample the brainmask in anatomical space

% Read the mean volume
mean_vol = spm_vol('/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/pet2anatmeansub-PADMTL0354_NAV_ses-01_pet_time-5070.nii');

brainmask_path = '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/tpl_brainmask.nii,1';

% Extract the directory of the brainmask
[brainmask_dir, ~, ~] = fileparts(brainmask_path);  % Get directory path

% Assume dim_t1 contains the FOV in mm for each dimension
dim_t1 = mean_vol.dim;  % Here, you load the dimensions of the mean volume

% Extract the transformation matrix from the mean_vol header
voxel_size = mean_vol.mat(1:3, 1:3); % Extract the voxel size from the transformation matrix
voxel_size = sqrt(sum(voxel_size.^2)); % Calculate the voxel size in each dimension

% Use dim_t1 to define the Field of View (FOV)
% Bounding box should span -FOV/2 to +FOV/2 for each dimension
bounding_box = [-dim_t1(1)/2, -dim_t1(2)/2, -dim_t1(3)/2;
                 dim_t1(1)/2,  dim_t1(2)/2,  dim_t1(3)/2];

% Normalize mask
matlabbatch{8}.spm.spatial.normalise.write.subj.def = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat/workdir/sub-PADMTL0354_NAV_ses-01_iy_sub-PADMTL0354_NAV_ses-01_T1w.nii'};
matlabbatch{8}.spm.spatial.normalise.write.subj.resample = {brainmask_path};

% Set bounding box based on dim_t1 (FOV)
matlabbatch{8}.spm.spatial.normalise.write.woptions.bb = [bounding_box(1, :);
                                                          bounding_box(2, :)];

% Set voxel size based on the mean volume
matlabbatch{8}.spm.spatial.normalise.write.woptions.vox = voxel_size;

matlabbatch{8}.spm.spatial.normalise.write.woptions.interp = 1;

% Set output prefix
matlabbatch{8}.spm.spatial.normalise.write.woptions.prefix = 'tpl2anat_';

% Set the output directory to the same directory as tpl_brainmask.nii
matlabbatch{8}.spm.util.imcalc.outdir = {brainmask_dir};

