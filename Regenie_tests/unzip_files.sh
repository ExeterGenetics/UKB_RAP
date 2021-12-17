#!/bin/sh
bed_file_dir="/regenie_step1_450k/"
bfile="regenie_step1_genotypes_450k_exomes_nov21.bim.gz"

output_dir="/Daniel/regenie_step_1_input"
command="bgzip -d ${bfile}"

dx run swiss-army-knife -iin="${bed_file_dir}${bfile}" \
   -icmd="${command}" --tag="unpack" --instance-type "mem1_ssd1_v2_x16"\
   --destination="${project}:${output_dir}" --brief --yes