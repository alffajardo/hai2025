%-----------------------------------------------------------------------
% Job saved on 08-Oct-2024 19:28:19 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.realign.estwrite.data = {
                                                    {
                                                    '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070.nii,1'
                                                    '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070.nii,2'
                                                    '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070.nii,3'
                                                    '/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/pet/sub-PADMTL0354_NAV_ses-01_pet_time-5070.nii,4'
                                                    }
                                                    }';
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.95;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [0 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 0;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
matlabbatch{2}.spm.spatial.coreg.estwrite.ref = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat/workdir/sub-PADMTL0354_NAV_ses-01_msub-PADMTL0354_NAV_ses-01_T1w.nii,1'};
matlabbatch{2}.spm.spatial.coreg.estwrite.source(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
matlabbatch{2}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.interp = 7;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.prefix = 'pet2anat';
matlabbatch{3}.spm.spatial.normalise.write.subj.def = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat/workdir/sub-PADMTL0354_NAV_ses-01_y_sub-PADMTL0354_NAV_ses-01_T1w.nii'};
matlabbatch{3}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
matlabbatch{3}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{3}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{3}.spm.spatial.normalise.write.woptions.interp = 7;
matlabbatch{3}.spm.spatial.normalise.write.woptions.prefix = 'pet2tpl';
matlabbatch{4}.cfg_basicio.file_dir.cfg_fileparts.files(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{5}.spm.util.imcalc.input = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/template_spm12/tpl_brainmask_spm12.nii,1'};
matlabbatch{5}.spm.util.imcalc.output = 'tpl_brainmask';
matlabbatch{5}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{5}.spm.util.imcalc.expression = 'i1';
matlabbatch{5}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{5}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{5}.spm.util.imcalc.options.mask = 0;
matlabbatch{5}.spm.util.imcalc.options.interp = 0;
matlabbatch{5}.spm.util.imcalc.options.dtype = 4;
matlabbatch{6}.spm.util.imcalc.input(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{6}.spm.util.imcalc.input(2) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl_brainmask', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.util.imcalc.output = 'pet2tpl_masked';
matlabbatch{6}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{6}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{6}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{6}.spm.util.imcalc.options.mask = -1;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 16;
matlabbatch{7}.spm.spatial.smooth.data(1) = cfg_dep('Image Calculator: ImCalc Computed Image: pet2tpl_masked', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{7}.spm.spatial.smooth.fwhm = [4 4 4];
matlabbatch{7}.spm.spatial.smooth.dtype = 0;
matlabbatch{7}.spm.spatial.smooth.im = 0;
matlabbatch{7}.spm.spatial.smooth.prefix = 'pet2tpl_fwhm_04mm_';
matlabbatch{8}.spm.spatial.normalise.write.subj.def = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat/workdir/sub-PADMTL0354_NAV_ses-01_iy_sub-PADMTL0354_NAV_ses-01_T1w.nii'};
matlabbatch{8}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl_brainmask', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{8}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{8}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{8}.spm.spatial.normalise.write.woptions.interp = 1;
matlabbatch{8}.spm.spatial.normalise.write.woptions.prefix = 'tpl2anat';
matlabbatch{9}.spm.util.imcalc.input(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{9}.spm.util.imcalc.output = 'tpl2anat_brainmask';
matlabbatch{9}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{9}.spm.util.imcalc.expression = 'i1 > 0.1';
matlabbatch{9}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{9}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{9}.spm.util.imcalc.options.mask = 0;
matlabbatch{9}.spm.util.imcalc.options.interp = 0;
matlabbatch{9}.spm.util.imcalc.options.dtype = 4;
matlabbatch{10}.spm.util.imcalc.input(1) = cfg_dep('Coregister: Estimate & Reslice: Coregistered Images', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','cfiles'));
matlabbatch{10}.spm.util.imcalc.input(2) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl2anat_brainmask', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.util.imcalc.output = 'masked_meanpetvol';
matlabbatch{10}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{10}.spm.util.imcalc.expression = 'i2.*i1';
matlabbatch{10}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{10}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{10}.spm.util.imcalc.options.mask = 0;
matlabbatch{10}.spm.util.imcalc.options.interp = 0;
matlabbatch{10}.spm.util.imcalc.options.dtype = 16;
matlabbatch{11}.spm.spatial.coreg.write.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl2anat_brainmask', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{11}.spm.spatial.coreg.write.source(1) = cfg_dep('Image Calculator: ImCalc Computed Image: masked_meanpetvol', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{11}.spm.spatial.coreg.write.roptions.interp = 0;
matlabbatch{11}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
matlabbatch{11}.spm.spatial.coreg.write.roptions.mask = 0;
matlabbatch{11}.spm.spatial.coreg.write.roptions.prefix = 'pet2anat_2mm_vol';
matlabbatch{12}.spm.spatial.smooth.data(1) = cfg_dep('Image Calculator: ImCalc Computed Image: masked_meanpetvol', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{12}.spm.spatial.smooth.fwhm = [2 2 2];
matlabbatch{12}.spm.spatial.smooth.dtype = 0;
matlabbatch{12}.spm.spatial.smooth.im = 0;
matlabbatch{12}.spm.spatial.smooth.prefix = 'fwhm_4mm_';
matlabbatch{13}.spm.util.imcalc.input = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/template_spm12/voi_WhlCbl_2mm_spm12.nii,1'};
matlabbatch{13}.spm.util.imcalc.output = 'tpl_2mm_WC';
matlabbatch{13}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{13}.spm.util.imcalc.expression = 'i1';
matlabbatch{13}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{13}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{13}.spm.util.imcalc.options.mask = 0;
matlabbatch{13}.spm.util.imcalc.options.interp = 0;
matlabbatch{13}.spm.util.imcalc.options.dtype = 4;
matlabbatch{14}.spm.spatial.normalise.write.subj.def = {'/Users/alfonsofajardovaldez/Documents/GitHub/hai2025/spm12_code/sub-PADMTL0354_NAV_ses-01/anat/workdir/sub-PADMTL0354_NAV_ses-01_iy_sub-PADMTL0354_NAV_ses-01_T1w.nii'};
matlabbatch{14}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl_2mm_WC', substruct('.','val', '{}',{13}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{14}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                           78 76 85];
matlabbatch{14}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{14}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{14}.spm.spatial.normalise.write.woptions.prefix = 'tpl2anat';
matlabbatch{15}.spm.util.imcalc.input(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{14}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{15}.spm.util.imcalc.output = 'tpl2anat_WCmask_bin';
matlabbatch{15}.spm.util.imcalc.outdir(1) = cfg_dep('Get Pathnames: Directories', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','p'));
matlabbatch{15}.spm.util.imcalc.expression = 'i1 > 0.1';
matlabbatch{15}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{15}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{15}.spm.util.imcalc.options.mask = 0;
matlabbatch{15}.spm.util.imcalc.options.interp = 1;
matlabbatch{15}.spm.util.imcalc.options.dtype = 4;
matlabbatch{16}.spm.spatial.coreg.write.ref(1) = cfg_dep('Image Calculator: ImCalc Computed Image: tpl2anat_WCmask_bin', substruct('.','val', '{}',{15}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{16}.spm.spatial.coreg.write.source(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{12}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{16}.spm.spatial.coreg.write.roptions.interp = 0;
matlabbatch{16}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
matlabbatch{16}.spm.spatial.coreg.write.roptions.mask = 0;
matlabbatch{16}.spm.spatial.coreg.write.roptions.prefix = 'resampled_2mm';
