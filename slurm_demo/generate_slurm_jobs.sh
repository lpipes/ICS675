#!/usr/bin/bash

PARTITION="ics675"
ACCOUNT="ics675"
TIME="01:00:00"
BOWTIE2_INDEX="/home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta"
INPUT_DIR="/home/lpipes/koa_scratch/lpipes/fastq_files"
OUTPUT_DIR="/home/lpipes/koa_scratch/lpipes/bowtie2_out"
TOTAL_FILES=100
SCRIPTS=10
FILES_PER_SCRIPT=$(( TOTAL_FILES / SCRIPTS ))
THREADS_PER_JOB=1
CPUS_NEEDED=$(( FILES_PER_SCRIPT * THREADS_PER_JOB ))  # CPUs to request in SBATCH
# -----------------

mkdir -p "${OUTPUT_DIR}"

for i in $(seq 0 $((SCRIPTS-1))); do
  start=$(( i * FILES_PER_SCRIPT + 1 ))
  end=$(( (i + 1) * FILES_PER_SCRIPT ))
  slurm="/home/lpipes/koa_scratch/lpipes/Parallel_slurm/bowtie2_batch_${i}.slurm"

  cat > "${slurm}" <<EOF
#!/bin/bash
#SBATCH --job-name=bt2_${i}
#SBATCH --partition=${PARTITION}
#SBATCH --account=${ACCOUNT}
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=${CPUS_NEEDED}
#SBATCH --time=${TIME}
#SBATCH --output=bt2_${i}.%j.out
#SBATCH --error=bt2_${i}.%j.err
# #SBATCH --mem-per-cpu=1G

module load bio/Bowtie2/2.4.5-GCC-11.3.0
mkdir -p "${OUTPUT_DIR}"

echo "Starting bowtie2 batch ${i}: reads ${start}-${end} with ${CPUS_NEEDED} CPUs on a single node..."
EOF

  for j in $(seq "${start}" "${end}"); do
    file="${INPUT_DIR}/read_${j}.fastq"
    sam="${OUTPUT_DIR}/read_${j}.sam"
    echo "bowtie2 -p ${THREADS_PER_JOB} -x ${BOWTIE2_INDEX} -U ${file} -S ${sam} &" >> "${slurm}"
  done

  cat >> "${slurm}" <<'EOF'
wait
echo "All bowtie2 tasks in this batch finished."
EOF

  chmod +x "${slurm}"
  echo "Wrote ${slurm} covering reads ${start}-${end}"
done
