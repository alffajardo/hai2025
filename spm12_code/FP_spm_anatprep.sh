#!/bin/bash

# Author: Alfonso Fajardo-Valdez
# Date of Creation: 06-Oct-2024
# Purpose: This script sets up and runs a batch job for SPM12 to preprocess anatomical MRI images.

# SPM12 Path: the user can define it here directly if desired
spm12_path='/Users/alfonsofajardovaldez/Documents/MATLAB/spm12'  # Default path

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

# Function to show script usage
usage() {
    echo -e "${YELLOW}Usage: $0 -b <bids_dir> -s <subject_id> [-a <anat_name>] [-m <spm12_path>] [-M <matlab_path>] [-v <voxel_size>] [-w]${NC}"
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  -b    Path to the BIDS directory (required)"
    echo -e "  -s    Subject ID (required)"
    echo -e "  -a    Anatomical file identifier (optional, default is <subject_id>_T1w.nii or .nii.gz)"
    echo -e "  -m    Path to SPM12 (optional, default is set inside the script)"
    echo -e "  -M    Path to MATLAB installation bin dir (optional), e.g /usr/local/MATLAB_R2020B/bin"
    echo -e "  -v    Voxel size for the output image in mm (optional, default is 2 mm)"
    echo -e "  -w    Overwrite existing outputs (optional)"
    echo -e "  -h    Show this help message and exit"
    exit 1
}

# Argument parsing using case
overwrite=false  # Variable to determine if overwrite is allowed
voxel_size=2  # Default voxel size is 2 mm
while getopts "b:s:a:m:M:v:wh" opt; do
  case ${opt} in
    b) bids_dir=${OPTARG} ;;     # BIDS directory
    s) subject_id=${OPTARG} ;;   # Subject ID
    a) anat_prefix=${OPTARG} ;;  # Anatomical prefix (optional)
    m) spm12_path=${OPTARG} ;;   # SPM12 path
    M) matlab_path=${OPTARG} ;;  # MATLAB path
    v) voxel_size=${OPTARG} ;;   # Voxel size
    w) overwrite=true ;;         # Enable overwrite
    h) usage ;;                  # Show help if -h is passed
    *) usage ;;                  # Show usage if invalid option
  esac
done


# Check that required arguments have been provided
[[ -z "$bids_dir" || -z "$subject_id" ]] && usage

# Add MATLAB path to PATH variable if specified
if [[ -n "$matlab_path" ]]; then
    export PATH="$matlab_path:$PATH"
    echo -e "${GREEN}++ Added MATLAB path to PATH: $matlab_path${NC}"
fi

# Check if the template space image already exists
template_space_image="${bids_dir}/${subject_id}/anat/${subject_id}_space-tpl_T1w.nii"
if [[ -f "$template_space_image" && "$overwrite" = false ]]; then
    echo -e "${RED}** ERROR: The template space image ${template_space_image} already exists. Use -w to overwrite.${NC}"
    exit 1
fi

# Initialization
echo -e "${GREEN}++ Initializing...${NC}"
sleep 2

# Create workdir
workdir=${bids_dir}/${subject_id}/anat/workdir

if [ "$overwrite" = true ]; then
    echo "++ The directory $workdir already exists and will be removed due to overwrite option."
    rm -rf "$workdir"
fi
mkdir -p "$workdir" || { echo -e "${RED}** ERROR: Failed to create workdir: $workdir${NC}"; exit 1; }



# Search for anatomical file
if [[ -z "$anat_prefix" ]]; then
    anat_file="${bids_dir}/${subject_id}/anat/${subject_id}_T1w.nii"
    anat_file_gz="${bids_dir}/${subject_id}/anat/${subject_id}_T1w.nii.gz"

    if [[ -f "$anat_file" ]]; then
        echo -e "${GREEN}++ Found anatomical file: $anat_file${NC}"
    elif [[ -f "$anat_file_gz" ]]; then
        echo -e "${YELLOW}++ Found compressed anatomical file: $anat_file_gz${NC}"
        echo -e "${GREEN}++ Decompressing $anat_file_gz...${NC}"
        gunzip "$anat_file_gz" || { echo -e "${RED}** ERROR: Failed to decompress $anat_file_gz${NC}"; exit 1; }
        anat_file="$anat_file"
    else
        echo -e "${RED}** ERROR: No anatomical file found for ${subject_id} (tried ${subject_id}_T1w.nii and ${subject_id}_T1w.nii.gz)${NC}"
        exit 1
    fi
else
    anat_file="${bids_dir}/${subject_id}/anat/${subject_id}_${anat_prefix}.nii"
    anat_file_gz="${bids_dir}/${subject_id}/anat/${subject_id}_${anat_prefix}.nii.gz"

    if [[ -f "$anat_file" ]]; then
        echo -e "${GREEN}++ Found anatomical file: $anat_file${NC}"
    elif [[ -f "$anat_file_gz" ]]; then
        echo -e "${YELLOW}++ Found compressed anatomical file: $anat_file_gz${NC}"
        echo -e "${GREEN}++ Decompressing $anat_file_gz...${NC}"
        gunzip "$anat_file_gz" || { echo -e "${RED}** ERROR: Failed to decompress $anat_file_gz${NC}"; exit 1; }
        anat_file="$anat_file"
    else
        echo -e "${RED}** ERROR: No anatomical file found for ${subject_id} with prefix ${anat_prefix} (tried .nii and .nii.gz)${NC}"
        exit 1
    fi
fi

# Copy anatomical file to workdir
cp -v "$anat_file" "$workdir" || { echo -e "${RED}** ERROR: Failed to copy anatomical file.${NC}"; exit 1; }

# Generate MATLAB job file
echo -e "
% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {'${bids_dir}/${subject_id}/anat_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:}); 
quit" > ${bids_dir}/${subject_id}/anat.m

# Generate SPM12 job file
unset Rev
echo -e "
%-----------------------------------------------------------------------
% Job saved on $(date '+%d-%b-%Y %H:%M:%S') by cfg_util (rev \$Rev: 7345 \$)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.preproc.channel.vols = {'${workdir}/${subject_id}_T1w.nii,1'};
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'${spm12_path}/tpm/TPM.nii,1'};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'${spm12_path}/tpm/TPM.nii,2'};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'${spm12_path}/tpm/TPM.nii,3'};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'${spm12_path}/tpm/TPM.nii,4'};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'${spm12_path}/tpm/TPM.nii,5'};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'${spm12_path}/tpm/TPM.nii,6'};
matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{1}.spm.spatial.preproc.warp.write = [1 1];
matlabbatch{1}.spm.spatial.preproc.warp.vox = [${voxel_size} ${voxel_size} ${voxel_size}];
matlabbatch{1}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                              NaN NaN NaN];
matlabbatch{2}.cfg_basicio.file_dir.cfg_fileparts.files(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{3}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{3}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{3}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{3}.spm.spatial.normalise.write.woptions.vox = [${voxel_size} ${voxel_size} ${voxel_size}];
matlabbatch{3}.spm.spatial.normalise.write.woptions.interp = 7;
matlabbatch{3}.spm.spatial.normalise.write.woptions.prefix = 'w';  
" > ${bids_dir}/${subject_id}/anat_job.m

echo "++ Done!"
sleep 1
echo "++ Launching $subject_id Structural Preprocessing Batch..."
sleep 1.5

# Launch the MATLAB JOB
echo "++ Running MATLAB script for $subject_id..."
matlab_status="FAILED"
if matlab \
 -nodesktop \
 -nodisplay \
 -nosplash \
 -nojvm \
 -r "addpath('$spm12_path') ; run('${bids_dir}/${subject_id}/anat.m'); quit" 2>&1 | tee ${bids_dir}/${subject_id}/struct_prep.log; then
    echo -e "${GREEN}++ MATLAB job completed successfully for $subject_id${NC}"
    matlab_status="SUCCESS"
else
    echo -e "${RED}** ERROR: MATLAB job failed for $subject_id. Check the log at ${bids_dir}/${subject_id}/struct_prep.log${NC}"
    exit 1
fi

# Copy the output file to final destination
output_file="${bids_dir}/${subject_id}/anat/${subject_id}_space-tpl_T1w.nii"
source_file="${workdir}/wm${subject_id}_T1W.nii"

copy_status="FAILED"
if cp -v "$source_file" "$output_file"; then
    echo -e "${GREEN}++ Successfully copied the output file to $output_file${NC}"
    copy_status="SUCCESS"
else
    echo -e "${RED}** ERROR: Failed to copy the output file. Please check the paths and permissions.${NC}"
    exit 1
fi

# Renaming files in the workdir with subject_id prefix and clearer names
echo "++ Renaming files in the workdir to more descriptive names for $subject_id..."

# Create a dictionary of known filenames and their descriptive counterparts
declare -A filename_map=(
    ["c1"]="gray_matter_segment"
    ["c2"]="white_matter_segment"
    ["c3"]="csf_segment"
    ["m"]="bias_corrected"
    ["wm"]="warped_image"
)

renamed_files=0
for file in "$workdir"/*; do
    filename=$(basename "$file")
    new_filename="$subject_id"

    # Check if the file starts with known SPM prefix (like y_, iy_, c1, etc.)
    for prefix in "${!filename_map[@]}"; do
        if [[ "$filename" == ${prefix}* ]]; then
            suffix="${filename#${prefix}}"  # Remove the prefix
            new_filename+="_${filename_map[$prefix]}_${suffix}"  # Build the new descriptive filename
            break
        fi
    done

    # If no match was found in the prefix map, just append the original filename
    if [[ "$new_filename" == "$subject_id" ]]; then
        new_filename+="_${filename}"  # For unknown files, just prepend the subject_id
    fi

    mv -v "$file" "$workdir/$new_filename"
    ((renamed_files++))  # Count the renamed files
done

echo -e "${GREEN}++ Files renamed successfully in $workdir${NC}"

# Final check if the anatomical file in template space exists
template_file_status="FAILED"
if [ -f "$output_file" ]; then
    echo
    echo -e "${GREEN}++ Anatomical file in template space was successfully generated!!${NC}"
    template_file_status="SUCCESS"
else
    echo -e "${RED}** ERROR: The anatomical file in template space was not generated! Please check the logs for errors.${NC}"
    exit 1
fi

# Calculate Field of View (FOV)
# Typical MNI space dimensions: 79 x 95 x 68
fov_x=$(echo "$voxel_size * 79" | bc)
fov_y=$(echo "$voxel_size * 95" | bc)
fov_z=$(echo "$voxel_size * 68" | bc)

# Summary of the execution
echo > $bids_dir/${subject_id}/anat_execsum.txt
echo "++ ===================== Execution Summary =====================" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Subject ID:                $subject_id" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ MATLAB job status:         $matlab_status" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Files renamed:             $renamed_files" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Copy of warped file:       $copy_status" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Anatomical template file:  $template_file_status" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Voxel size (mm):           ${voxel_size} x ${voxel_size} x ${voxel_size}" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Field of View (mm):        ${fov_x} x ${fov_y} x ${fov_z}" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ Final output location:     $output_file" >> $bids_dir/${subject_id}/anat_execsum.txt
echo "++ ============================================================="
echo -e "++ Finished: $(date)" >> $bids_dir/${subject_id}/anat_execsum.txt