#!/bin/sh



# Bed files
bed_file_dir="/Daniel/regenie_step_1_input/"
bfile="regenie_step1_genotypes_450k_exomes_nov21"
bed_file="${bed_file_dir}${bfile}.bed"
bim_file="${bed_file_dir}${bfile}.bim"
fam_file="${bed_file_dir}${bfile}.fam"

# pheno and covar settings
trait_dir="/Daniel/example_traits/"
pheno_file="northing.pheno"
covar_file="northing.covar"
covars="sex,centre,wes_batch"

# output vars
output="northing_step_1_test"
output_dir="/Daniel/test_1/"

run_regenie_step1="regenie --step 1\
 --out ${output} --bed ${bfile}\
 --phenoFile ${pheno_file} --covarFile ${covar_file}\
 --catCovarList ${covars}\
 --bsize ${bsize}\
 --maxCatLevels 30\
 --apply-rint${lowmem}${verbose}${threads}"

dx run swiss-army-knife -iin="${bed_file}"\
   -iin="${bim_file}"\
   -iin="${fam_file}"\
   -iin="${trait_dir}${pheno_file}"\
   -iin="${trait_dir}${covar_file}"\
   -icmd="${run_regenie_step1}" --tag "${tag}" --name "${name}" --instance-type "${instance_type}"\
   --destination="${project}:${output_dir}" --brief --yes --priority low #--cost-limit=10 #"${cost_limit}"



# Regenie 
# --step 1 \
# --bed regenie_step1_450k/regenie_step1_genotypes_450k_exomes_nov21 \
# --phenoFile Phenotype_TSV \--covarFile Covariate_TSV \
# --bsize 1000 \
# --apply-rint \
# --catCovarList sex,centre,wes_batch \
# --maxCatLevels 30 \
# --extract northing_birth_pcs_snplist_mac100.snplist \
# --out northing_birth_pcs_Step1

