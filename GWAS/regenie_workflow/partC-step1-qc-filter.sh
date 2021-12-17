#!/bin/sh

# This script runs the QC process using PLINK on the merged file generated in 
# partB-merge-files-dxfuse.sh as described in the 

# Requirements: 
# (0-4). Please see readme.md
# 5. Must have executed partB-merge-files-dx-fuse.sh

# How to Run:
# Run this shell script using: 
# sh 02-step1-qc-filter.sh 
# on the command line on your machine



# Outputs: 
# - /Data/WES_array_snps_qc_pass.snplist - Used as input for part D 
# - /Data/WES_array_snps_qc_pass.log
# - /Data/WES_array_snps_qc_pass.id

#set output directory (also location of merged files)
data_file_dir="/Data/"
#data_file_dir="/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - interim 450k release/"
#data_field="23149"
pheno_file="zbw_wes_450k.phe"
data_field="22418"
bfile="ukb${data_field}_c1_22_v2_merged"



run_plink_qc="plink2 --bfile ${bfile}\
 --keep ${pheno_file} --autosome\
 --maf 0.01 --mac 20 --geno 0.1 --hwe 1e-15\
 --mind 0.1 --write-snplist --write-samples\
 --no-id-header --out  WES_array_snps_qc_pass"

dx run swiss-army-knife -iin="${data_file_dir}${bfile}.bed" \
   -iin="${data_file_dir}${bfile}.bim" \
   -iin="${data_file_dir}${bfile}.fam"\
   -iin="${data_file_dir}${pheno_file}" \
   -icmd="${run_plink_qc}" --tag="Step1" --instance-type "mem1_ssd1_v2_x16"\
   --destination="${project}:${data_file_dir}/" --brief --yes