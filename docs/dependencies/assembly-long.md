# Assembly-Long Module Dependencies

## Overview
The Assembly-Long module assembles long-read metagenomic sequencing data from technologies like Oxford Nanopore and PacBio. It handles the end-to-end process from assembly to read mapping, producing ready-to-use assemblies for downstream VEBA modules.

## Core Python Dependencies
- pandas: Data manipulation and analysis
- soothsayer_utils: Utility functions for bioinformatics
- genopype: Pipeline management framework

## External Tools
- Flye/MetaFlye: Long-read genome assembler
- MiniMap2: Alignment tool for long reads
- Samtools: Utilities for manipulating alignments
- featureCounts (Subread package): Read counting tool
- Seqkit: FASTA/Q sequence manipulation and statistics

## Databases
- No reference databases required

## Environment Details
The module uses the standard assembly Conda environment specified in `VEBA-assembly_env.yml`:
```
name: VEBA-assembly_env
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - flye
  - minimap2
  - samtools
  - subread
  - seqkit
  - pandas
  - pip
  - pip:
    - soothsayer_utils
    - genopype
```

## Pipeline Process
1. **Assembly**:
   - Runs Flye/MetaFlye on input long reads with appropriate settings for read type
   - Supports various read technologies (Nanopore, PacBio)
   - Filters small contigs based on minimum length threshold

2. **Read Mapping**:
   - Creates an index of assembled contigs using MiniMap2
   - Maps raw reads back to the assembly
   - Generates sorted and indexed BAM files

3. **Read Counting**:
   - Counts reads mapped to each scaffold using featureCounts
   - Organizes count data in a standardized format

4. **Statistics Generation**:
   - Calculates assembly statistics with Seqkit
   - Creates standardized output files for downstream analysis

## Requirements
- Input files must be in FASTQ format (gzipped or uncompressed)
- Sufficient memory for long-read assembly (depends on dataset size)
- For large metagenomes (>5GB), consider providing an estimated assembly size

## Usage
```bash
# Basic usage with Nanopore high-quality reads
veba --module assembly-long --params="-i reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16"

# Using PacBio HiFi reads
veba --module assembly-long --params="-i reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16 -t pacbio-hifi --minimap2_preset map-hifi"

# Specifying estimated genome size for large metagenomes
veba --module assembly-long --params="-i reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16 -g 5g"

# Using standard Flye instead of MetaFlye
veba --module assembly-long --params="-i reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16 -P flye"
```