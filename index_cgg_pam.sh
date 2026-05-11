#!/bin/bash
#SBATCH --job-name=run_crispritz_setup
#SBATCH --output=logs/crispritz_%A_%a.out
#SBATCH --error=logs/crispritz_%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --partition short

source ~/.research_config
cd $REF_GENOME_DIR
conda activate crispritz

# 1. separate out the hg38_main_chroms into distinct chromosomes
mkdir -p hg38_separate_chroms
cut -f1 hg38_main_chroms.fa.fai | while read chrom; do
  samtools faidx hg38_main_chroms.fa "$chrom" > hg38_separate_chroms/${chrom}.fa
done

# 2. 