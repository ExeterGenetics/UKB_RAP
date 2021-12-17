#!/bin/sh

# Requirements: 
# 0-4 - please refer to readme.md
# 5. Must have executed: 
# - partB-merge-files-dx-fuse.sh 
# - partC-step1-qc-filter.sh

# How to Run:
# Run this shell script using: 
#   sh partD-step1-qc-regenie.sh 
# on the command line on your own machine

# Inputs:
# Note that you can adjust the output directory by setting the data_file_dir variable
# - /Data/${pheno_file} - from part A (please refer to notebook & slides)
# - /Data/WES_array_snps_qc_pass.snplist - from part C
# - /Data/ukb22418_c1_22_merged.bed - from part B
# - /Data/ukb22418_c1_22_merged.bed - from part B
# - /Data/ukb22418_c1_22_merged.bed - from part B

# Outputs:
# - /Data/diabetes_results_1.loco.gz - Leave One Chromosome Out results (used in part F)
# - /Data/diabetes_results_pred.list - List of files generated this step (used in part F)
# - /Data/diabetes_results.log


#output directory - this should also be where the files in 02-step1-qc-filter.sh end up
data_file_dir="/Data/"
pheno_file="zbw_wes_450k.phe"
data_field="22418"
bfile="ukb${data_field}_c1_22_v2_merged"
output="BW_results"
SNP_LIST="WES_array_snps_qc_pass.snplist"

run_regenie_step1="regenie --step 1\
 --out ${output} --bed ${bfile}\
 --phenoFile ${pheno_file} --covarFile ${pheno_file}\
 --extract ${SNP_LIST} --phenoCol bw_z --covarCol sex\
 --bsize 1000 --lowmem --loocv --gz --threads 16"

dx run swiss-army-knife -iin="${data_file_dir}${bfile}.bed" \
   -iin="${data_file_dir}${bfile}.bim" \
   -iin="${data_file_dir}${bfile}.fam"\
   -iin="${data_file_dir}${SNP_LIST}" \
   -iin="${data_file_dir}${pheno_file}" \
   -icmd="${run_regenie_step1}" --tag="Step1" --instance-type "mem1_ssd1_v2_x16"\
   --destination="${project}:${data_file_dir}" --brief --yes