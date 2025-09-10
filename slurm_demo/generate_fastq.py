#!/usr/bin/python
import os

seq = "TCTACCCACCATACAGTATATTATTGGTAAAGAACCTAAACTCACTGTTGCTGCCAACTATTTATCTATC"
quality = "I" * len(seq)

outdir = "/home/lpipes/koa_scratch/lpipes/fastq_files"
os.makedirs(outdir, exist_ok=True)

for i in range(1, 101):
    filename = os.path.join(outdir, f"read_{i}.fastq")
    with open(filename, "w") as f:
        f.write(f"@read{i}\n")
        f.write(seq + "\n")
        f.write("+\n")
        f.write(quality + "\n")
