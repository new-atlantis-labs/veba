# Assembly Module Dependencies

## Overview
The assembly module in VEBA is responsible for assembling metagenomic/genomic reads into contigs and scaffolds. It supports multiple assemblers including metaSPAdes, SPAdes, MEGAHIT, RNASPAdes, and others. The module includes read alignment back to assemblies to generate coverage information and statistics.

## Core Python Dependencies
- **genopype**: Workflow management framework
- **soothsayer_utils**: Utility functions for bioinformatics pipelines
- **pandas**: Data manipulation and analysis
- **biopython**: Python tools for computational molecular biology
- **tqdm**: Progress bar library

## External Tools
- **Assemblers**:
  - SPAdes/metaSPAdes/RNASPAdes: De Bruijn graph-based assemblers for various applications
  - MEGAHIT: Ultra-fast and memory-efficient metagenome assembler
  
- **Alignment & Processing**:
  - Bowtie2: Fast and sensitive read aligner
  - Samtools: Suite of programs for manipulating alignments in SAM/BAM format
  - featureCounts (Subread package): Read counting tool
  - Seqkit: Fast and versatile FASTA/Q file manipulation toolkit
  - gfastats: Graph FASTA statistics toolkit

## Databases
- No specific reference databases are required for this module

## Environment Details
The assembly module uses the `VEBA-assembly_env` conda environment with the following key components:
- Python 3.9
- SPAdes 3.15.5
- MEGAHIT 1.2.9
- Bowtie2 2.5.0
- Samtools 1.16.1
- featureCounts (via Subread 2.0.3)
- Seqkit 2.3.1
- Other dependencies including biopython, pandas, and required C/C++ libraries

## Pipeline Process
1. **Assembly**: Using one of the supported assemblers (metaSPAdes, SPAdes, MEGAHIT, etc.)
   - Filters small contigs based on user-defined minimum length
   - Adds customizable prefix to scaffold IDs
   - Creates scaffold paths and SAF (Simplified Annotation Format) files

2. **Alignment**: Maps reads back to assembled scaffolds
   - Uses Bowtie2 to create an index and align reads
   - Generates a sorted BAM file with Samtools

3. **Read Counting**: Counts reads mapped to scaffolds
   - Uses featureCounts to generate read counts per scaffold

4. **Statistics**: Calculates assembly statistics
   - Uses Seqkit to generate sequence statistics

5. **Output Organization**: Creates symbolic links to relevant output files in the output directory

## Requirements
- Adequate memory for assembly (configurable, defaults to 250GB for SPAdes and 99% of system memory for MEGAHIT)
- Sufficient disk space for intermediate files and outputs
- Multi-threading capability for improved performance

## Usage
Basic command:
```bash
veba --module assembly --params "-1 forward_reads.fastq.gz -2 reverse_reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16"
```

Example for using metaSPAdes:
```bash
veba --module assembly --params "-1 cleaned_1.fastq.gz -2 cleaned_2.fastq.gz -n SAMPLE_ID -o veba_output/assembly -p 16 -P metaspades.py"
```

Example for using MEGAHIT:
```bash
veba --module assembly --params "-1 cleaned_1.fastq.gz -2 cleaned_2.fastq.gz -n SAMPLE_ID -o veba_output/assembly -p 16 -P megahit --megahit_preset meta-sensitive"
```