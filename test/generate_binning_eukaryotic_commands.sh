#!/usr/bin/env bash

# Setup
module="binning-eukaryotic"
output_directory="../Analysis/veba_output/binning/eukaryotic"
commands_file="commands.${module}.list"
veba_database="/home/ubuntu/jolespin-volume/s3/newatlantis-raw-veba-db-prod/VEBA/VEBA-DB_v9/"

# Make the directory and clear existing files
mkdir -p ${output_directory}/
mkdir -p logs/
rm -f ${commands_file}
# Iterate through all samples in the identifier list
for id in $(cat ../identifiers.list);
do
        job_name="${module}__${id}"
        echo ${job_name}
        fasta="../Analysis/veba_output/binning/prokaryotic/${id}/output/unbinned.fasta"
        bam="../Analysis/veba_output/assembly/${id}/output/mapped.sorted.bam"
        params="-f ${fasta} -b ${bam} -n ${id} -o ${output_directory} -p=4 -m 1500 --veba_database ${veba_database}"
        cmd="/usr/bin/time -v veba --module ${module} --params \"${params}\""
        echo "${cmd} 2> logs/${job_name}.e 1> logs/${job_name}.o" >> ${commands_file}

done

