#!/bin/bash
#SBATCH --job-name=repeatmasker_chrY
#SBATCH --output=logs/repeatmasker_chrY_%j.out
#SBATCH --error=logs/repeatmasker_chrY_%j.err
#SBATCH --time=4:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --partition short

set -euo pipefail

# load software
module load conda/miniforge3/24.11.3-0
source /n/app/conda/miniforge3/24.11.3-0/etc/profile.d/conda.sh
conda activate repeatmasker

# set fps
source ~/.research_config
fa_file="${REF_GENOME_DIR}/chrY_separate_chroms/chrY.fa"
out_dir="${REF_GENOME_DIR}/repeatmasker_chrY"
lib_dir="${LOCAL_INTERNAL_SCRATCH_DIR}/repeatmasker_data"

mkdir -p "$out_dir"

# run RepeatMasker
RepeatMasker \
  -engine rmblast \
  -libdir "$lib_dir" \
  -species human \
  -pa 1 \
  -gff \
  -dir "$out_dir" \
  "$fa_file"
