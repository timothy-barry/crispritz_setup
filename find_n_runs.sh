#!/bin/bash
#SBATCH --job-name=find_n_runs
#SBATCH --output=logs/find_n_runs_%A_%a.out
#SBATCH --error=logs/find_n_runs_%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=6
#SBATCH --partition short

set -euo pipefail

# load software
module load conda/miniforge3/24.11.3-0
source /n/app/conda/miniforge3/24.11.3-0/etc/profile.d/conda.sh
conda activate crisprde-venv

# set fps
source ~/.research_config
#fa_file="${REF_GENOME_DIR}hg38_main_chroms.fa"
#out_file="${REF_GENOME_DIR}hg38_N_runs_min10.bed"

fa_file=${REF_GENOME_DIR}"/hg38_separate_chroms/chrY.fa"
out_file=${REF_GENOME_DIR}"/chrY_N_runs_min10.bed"

seqkit locate \
  --bed \
  --ignore-case \
  --only-positive-strand \
  --pattern "NNNNNNNNNN" \
  --threads "${SLURM_CPUS_PER_TASK:-6}" \
  "$fa_file" \
  | sort -k1,1 -k2,2n \
  | bedtools merge -i - \
  | awk 'BEGIN{OFS="\t"} {print $1, $2, $3, "N_run", 0, "+"}' \
  > "$out_file"
