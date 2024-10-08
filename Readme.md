# FAJARDITO'S pREP

`FajarditosPrep` is under construction.


#### Coming soon..

## **Description:**

The  general aims for this project are: 

1. Evaluate differences in the Aβ Centiloids across four distinct preprocessing pipelines:  `SPM12` , `FSL` , `AFNI` and `FSL + ANTs` .
2. Evaluate the robustness/consistency of the CL cut-off thresholds when classifying individuals as Aβ+ or Aβ-.
3. Test the reproducibility of higher-level statistics across  different pipelines and MRI software tools. 
4. Evaluate the impact of the distinct Aβ status clarifications on Tau PET higher level voxelwise and ROI-based statistics.

---

## Data

The analyses will be conducted in three different datasets: 

- GAAIN
- PREVENT-AD
- ADNI

---

## Preprocessing

- All images are first reoriented to standard space by using `fslreorien2std`.
- In the PREVENT-AD dataset, the first two volumes are trimmed manually via `fslroi` to keep only the 50-70 min post-injection timeframes.

### SPM12

#### Structural

#### PET

1. If necessary align the mass centers of the PET and anatomical images manually.
2. Alignment of PET timeseries to the mean average volume. 
3. Averge of motion-corrected timeframes to obtain 1 single PET volume. 
4. Corregistration to anatomical scan (Estimation).
5. Warping to MNI152 space.
6. Masking to remove ventricle and CSF signal.
7. Spatial smoothing (Distinct Kernels are tested).

### FSL

### AFNI

