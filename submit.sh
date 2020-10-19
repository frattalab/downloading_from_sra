#!/bin/bash
#Submit to the cluster, give it a unique name
#$ -S /bin/bash

#$ -cwd
#$ -V
#$ -l h_vmem=1.9G,h_rt=72:00:00,tmem=1.9G


# join stdout and stderr output
#$ -j y
#$ -sync y


FOLDER=submissions/$(date +"%Y%m%d%H%M")
if [ "$1" != "" ]; then
    RUN_NAME=$1
else
    RUN_NAME=$"run_config"
fi

mkdir -p $FOLDER
mkdir -p $FOLDER
cp download_srr_ena.smk $FOLDER/$RUN_NAME'_download_srr.smk'

snakemake -s download_srr_ena.smk \
--jobscript cluster_qsub.sh \
--cluster-config cluster.yaml \
--cluster-sync "qsub -R y -l h_vmem={cluster.h_vmem},h_rt={cluster.h_rt} -o $FOLDER" \
-j 30 \
--nolock \
--rerun-incomplete \
--latency-wait 100
