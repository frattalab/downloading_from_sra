# downloading_from_sra
Simple code for downloading from SRA in a parallel manner

To work you need to have snakemake in your PATH environment.

1. Open the file called "download_srr.smk"

2. Edit the SRA_acc_file and OUTPUT_FOLDER variable appropiately, save the file.

3. SRA_acc_file is just a text file with no headers of the SRRnumbers you want to download

While inside this folder enter the following command:
source submit.sh


OR you can run it without submitting to the cluster if you'd like by just running "snakemake -s download_srr_ena.smk"


This submit.sh is designed for SGE, modify accordingly for your cluster setup. 
