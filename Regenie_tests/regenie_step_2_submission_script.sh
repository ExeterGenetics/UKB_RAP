#!/bin/sh

# trait and covar variables
trait_dir="/Daniel/example_traits/"
pheno_file="northing.pheno"
covar_file="northing.covar"
covars="sex,centre,wes_batch"

# bgen files
bgen_path="/bgen_8bit_450k_exomes/"


# loco files
loco_file="northing_test_lowmem_bsize_1000_reformat_1.loco"
pred_file="northing_test_lowmem_bsize_1000_reformat_pred.list"
loco_path="/Daniel/test_1/"

# anno files
anno_folder="/Daniel/masks/"


# other settings
instance_type="mem1_ssd1_v2_x16"
tag="regenie_step_2"
output_dir="/Daniel/regenie_step_2_output/"


 
for chr in {1..2}; do
    name="step_2_test_chr${chr}"
    run_regenie_step2="regenie --step 2 \
        --bgen ukb_${chr}.bgen \
        --sample ukb_${chr}.sample \
        --phenoFile ${pheno_file} --covarFile ${covar_file}\        
        --bsize 400 \
        --minMAC 1 \
        --catCovarList ${covars}\
        --maxCatLevels 30 \
        --apply-rint \
        --anno-file annotations_chr${chr}.txt \
        --set-list set_list_chr${chr}.txt \
        --mask-def masks \
        --pred ${pred_file} \
        --aaf-bins 0.001,0.0001 \
        --check-burden-files \
        --out step_2_assoc.chr${chr}"

    dx run swiss-army-knife -iin="${bgen_path}ukb_${chr}.bgen"\ ## bgen file
        -iin="${bgen_path}ukb_${chr}.sample"\ ## bgen sample
        -iin="${trait_dir}${pheno_file}"\
        -iin="${trait_dir}${covar_file}"\
        -iin="${loco_path}${loco_file}"
        -iin="${loco_path}${pred_file}"
        -iin="${anno_folder}annotations_chr${chr}.txt"
        -iin="${anno_folder}set_list_chr${chr}.txt"
        -icmd="${run_regenie_step2}" --tag "${tag}" --name "${name}" --instance-type "${instance_type}"\
        --destination="${project}:${output_dir}" --brief --yes --priority low #--cost-limit=10 #"${cost_limit}"
done


    # run_regenie_step2="regenie --step 2 \
    #     --bgen ukb_3.bgen \
    #     --sample ukb_3.sample \
    #     --phenoFile ${pheno_file} --covarFile ${covar_file}\        
    #     --bsize 400 \
    #     --minMAC 1 \
    #     --catCovarList ${covars}\
    #     --maxCatLevels 30 \
    #     --exclude ukb23149_450k_OQFE.90pct10dp_qc_variants.txt \
    #     --apply-rint \
    #     --anno-file annotations_chr3.txt \
    #     --set-list set_list_chr3.txt \
    #     --mask-def masks \
    #     --pred ${pred_file} \
    #     --aaf-bins 0.001,0.0001 \
    #     --check-burden-files \
    #     --out step_2_assoc.chr${chr}"
