#!/bin/bash
#SBATCH --job-name=download_repeatmasker_data
#SBATCH --output=logs/download_repeatmasker_data_%j.out
#SBATCH --error=logs/download_repeatmasker_data_%j.err
#SBATCH --time=8:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --partition short

set -euo pipefail

# set fps
source ~/.research_config
out_dir="${LOCAL_INTERNAL_SCRATCH_DIR}/repeatmasker_data"

mkdir -p "$out_dir"
cd "$out_dir"

# download FamDB root partition and human-containing partition
#base_url="https://www.dfam.org/releases/current/families/FamDB"

#wget "${base_url}/dfam39_full.0.h5.gz"
#wget "${base_url}/dfam39_full.0.h5.gz.md5"
#wget "${base_url}/dfam39_full.7.h5.gz"
#wget "${base_url}/dfam39_full.7.h5.gz.md5"

md5sum -c dfam39_full.0.h5.gz.md5
md5sum -c dfam39_full.7.h5.gz.md5

gunzip -f dfam39_full.0.h5.gz
gunzip -f dfam39_full.7.h5.gz
