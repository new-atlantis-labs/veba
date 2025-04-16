# Coverage Module Documentation

## Overview
The coverage module in VEBA processes short read mapping to reference sequences (contigs/scaffolds) and calculates coverage statistics. This module is critical for generating coverage information necessary for binning and quantification in metagenomic analyses using Illumina or other short-read technologies.

## Core Python Dependencies
- pandas
- genopype (VEBA's workflow framework)
- soothsayer_utils

## External Tools
- bowtie2/bowtie2-build
- samtools
- featureCounts
- seqkit
- GNU parallel

## Databases
- No external reference databases required

## Environment Details
The coverage module operates within the VEBA-assembly_env conda environment:
```
source activate VEBA-assembly_env
```

## Pipeline Process
1. **Index**
   - Filter reference sequences by minimum length
   - Create SAF file for featureCounts
   - Build bowtie2 index for short read mapping
   - Generate reference sequence statistics

2. **Alignment**
   - Map paired-end reads to reference sequences using bowtie2
   - Sort and index resulting BAM files

3. **Read Counting**
   - Count reads mapped to each feature using featureCounts
   - Generate a consolidated counts table across samples
   - Compress output files

4. **Output Organization**
   - Create symbolic links to relevant output files

## Requirements
- Paired-end reads in FASTQ format with a 3-column TSV file listing sample IDs and read files
- Reference sequences in FASTA format

## Usage
```
veba --module coverage --params "-f reference.fasta -r reads.tsv -o output_directory -p threads"
```

### Key Parameters
- `-f/--fasta`: Reference FASTA file
- `-r/--reads`: Reads table TSV file (3-column: sample ID, forward reads, reverse reads)
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-m/--minimum_contig_length`: Minimum contig length (default: 1)