
#THESE TWO LINES ARE ALL YOU NEED TO CHANGE
#first line is the full path to the SRR_Acclist that you downloading from the/SAN/vyplab/alb_projects/data/public_ribo_tags/hoye_2017 run selector
SRA_acc_file="/SAN/vyplab/FUS_RNA/Intron_retention/SHSY5Y_Differentiation_SRR.txt"
#then it's the path of the output folder the output folder must ALWAYS end in a slash /
OUTPUT_FOLDER="/SAN/vyplab/FUS_RNA/Intron_retention/"

kind = "sra"
#no need to touch anything past this point unless the clsuter people moved sra toolkit again, then update that line

ena_toolkit = "/home/annbrown/tools/enaBrowserTools/python3/enaDataGet"
sra_toolkit = "/share/apps/genomics/sratoolkit-2.9.6-1/bin/fasterq-dump"

def sra_acc_return(wildcards):
    #this function just returns the input file, it's a way of faking out snakemake
    return(SRA_acc_file)

SAMPLES = [line.rstrip('\n') for line in open(SRA_acc_file)]

rule all:
    input:
        expand(os.path.join(OUTPUT_FOLDER + "{name}/{name}.finished"), name = SAMPLES)
if kind == "ena":
    rule download:
        input:
            lambda wildcards: sra_acc_return(wildcards.name)
        output:
            out_folder = os.path.join(OUTPUT_FOLDER + "{name}/{name}.finished")
        params:
            ena = ena_toolkit
        shell:
            """
            mkdir -p {OUTPUT_FOLDER}
            {params.ena} {wildcards.name} -f fastq -d {OUTPUT_FOLDER}
            touch {output.out_folder}
            """
elif kind == "sra":
    rule download:
        input:
            lambda wildcards: sra_acc_return(wildcards.name)
        output:
            out_folder = os.path.join(OUTPUT_FOLDER + "{name}/{name}.finished")
        params:
            sra = sra_toolkit
        shell:
            """
            mkdir -p {OUTPUT_FOLDER}
            cd {OUTPUT_FOLDER}
            {params.sra} {wildcards.name} -t {OUTPUT_FOLDER} -e 4
            touch {output.out_folder}
            """
