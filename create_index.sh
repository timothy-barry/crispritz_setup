#!/bin/bash
#SBATCH --job-name=run_crispritz_setup
#SBATCH --output=logs/crispritz_%A_%a.out
#SBATCH --error=logs/crispritz_%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH --partition short

set -euo pipefail
shopt -s nullglob

module load conda/miniforge3/24.11.3-0
source /n/app/conda/miniforge3/24.11.3-0/etc/profile.d/conda.sh
conda activate crispritz
launch_dir=$(pwd)
source ~/.research_config
cd $REF_GENOME_DIR

# 1. separate out the hg38_main_chroms into distinct chromosomes
#mkdir -p hg38_separate_chroms
#cut -f1 hg38_main_chroms.fa.fai | while read chrom; do
#  samtools faidx hg38_main_chroms.fa "$chrom" > hg38_separate_chroms/${chrom}.fa
#done

# 2. create cas9 pam ref
#pam_file=$launch_dir"/cas9_pam_file.txt"
#crispritz.py index-genome crispritz_cas9_hg38 hg38_separate_chroms/ $pam_file -bMax 2 -th 4

# 3. create SpRY Cas9 PAM ref
spry_pam_file=$launch_dir"/spry_cas9_pam_file.txt"
crispritz.py index-genome crispritz_spry_hg38 hg38_separate_chroms/ $spry_pam_file -bMax 2 -th 4

