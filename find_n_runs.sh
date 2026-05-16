#!/bin/bash
#SBATCH --job-name=find_n_runs
#SBATCH --output=logs/find_n_runs_%A_%a.out
#SBATCH --error=logs/find_n_runs_%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=1
#SBATCH --partition short

set -euo pipefail

# load software
module load conda/miniforge3/24.11.3-0
source /n/app/conda/miniforge3/24.11.3-0/etc/profile.d/conda.sh
conda activate crisprde-venv

# run script
Rscript find_n_runs.R