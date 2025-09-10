#!/bin/bash
#SBATCH --job-name=bt2_0
#SBATCH --partition=ics675
#SBATCH --account=ics675
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --output=bt2_0.%j.out
#SBATCH --error=bt2_0.%j.err
# #SBATCH --mem-per-cpu=1G

module load bio/Bowtie2/2.4.5-GCC-11.3.0
mkdir -p "/home/lpipes/koa_scratch/lpipes/bowtie2_out"

echo "Starting bowtie2 batch 0: reads 1-10 with 10 CPUs on a single node..."
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_1.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_1.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_2.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_2.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_3.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_3.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_4.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_4.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_5.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_5.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_6.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_6.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_7.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_7.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_8.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_8.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_9.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_9.sam &
bowtie2 -p 1 -x /home/lpipes/koa_scratch/lpipes/bowtie2_database/AY545128.1.fasta -U /home/lpipes/koa_scratch/lpipes/fastq_files/read_10.fastq -S /home/lpipes/koa_scratch/lpipes/bowtie2_out/read_10.sam &
wait
echo "All bowtie2 tasks in this batch finished."
