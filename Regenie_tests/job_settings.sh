#!/bin/sh
dna_nexus_regenie_submit_path="/slade/home/dl498/code/UKB_RAP/Regenie_tests/regenie_submission_script.sh"


# instance_type="mem1_ssd1_v2_x16"
# bsize="2000"
# lowmem=" --lowmem"
# verbose=" --verbose"
# #threads=" --threads 16"
# threads=""
# #cost_limit="10"

# tag="${instance_type}_bs_${bsize}_lowmem_"
# name="SAK_${tag}"
# output="northing_test_${tag}"


# source ${dna_nexus_regenie_submit_path}


bsize_values=("1000")
#instance_values=("mem1_ssd1_v2_x2" "mem1_ssd1_v2_x4" "mem1_ssd1_v2_x8" "mem1_ssd1_v2_x36")
instance_values=("mem1_ssd1_v2_x72")
memory_values=("high" "low")

for mem_val in "${memory_values[@]}"; do    
    for b_val in "${bsize_values[@]}"; do    
        for inst_val in "${instance_values[@]}"; do
            instance_type="${inst_val}"
            bsize="${b_val}"
            if [ ${mem_val} = "low" ];then
                lowmem=" --lowmem"
            fi
            if [ ${mem_val} = "high" ];then
                lowmem=""
            fi

            verbose=" --verbose"
            #threads=" --threads 16"
            threads=""
            #cost_limit="10"

            tag="${instance_type}_bs_${bsize}_${mem_val}"
            name="SAK_${tag}"
            output="northing_test_${tag}"

            source ${dna_nexus_regenie_submit_path}

        done
    done
done
