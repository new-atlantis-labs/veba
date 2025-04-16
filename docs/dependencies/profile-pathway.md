# VEBA Profile-Pathway Module Dependencies

## Overview
The profile-pathway module performs functional profiling of metagenomic or metatranscriptomic samples by analyzing metabolic pathways. It leverages HUMAnN (HMP Unified Metabolic Analysis Network) to identify and quantify metabolic pathways from short read data, using either standard protein reference databases or custom databases derived from de novo assembled genomes.

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Data Processing**: pandas, numpy, scipy
- **Statistics**: statsmodels, seaborn
- **Sequence Handling**: biopython
- **Utilities**: tqdm, psutil

## External Tools
- **HUMAnN**: Main tool for pathway profiling (v3.8)
- **BBMerge**: Merges paired-end reads for analysis
- **Diamond**: Performs protein sequence alignment against reference databases
- **Seqkit**: Processes sequences and generates statistics
- **Samtools**: Processes BAM files when used as input

## Databases
- **UniRef**: Standard protein reference databases (UniRef50 or UniRef90)
- **Custom Databases**: Can use protein databases created from annotations of de novo assembled genomes
- **ChocoPhlAn**: Pangenome database used by HUMAnN (optional)

## Environment Details
The module requires a specific conda environment (`VEBA-profile_env`):

### Main Packages
- python=3.10.12
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- humann=3.8
- diamond=2.1.8
- bbmap=39.01
- seqkit=2.5.1
- pandas=2.1.1
- numpy=1.26.0
- samtools=1.18

## Pipeline Process
1. **Input Processing**:
   - Handles different input formats (paired-end reads, BAM files, or pre-joined reads)
   - For paired-end reads, merges them using BBMerge
   - Generates sequence statistics for quality control

2. **Database Preparation**:
   - Processes database files (FASTA or Diamond database)
   - Creates or links Diamond database for protein searches

3. **HUMAnN Analysis**:
   - Performs protein search using Diamond
   - Identifies metabolic pathways based on protein hits
   - Calculates pathway abundance and coverage
   - Generates gene family profiles

4. **Output Processing**:
   - Produces pathway abundance, coverage, and gene family tables
   - Maintains alignment information for both aligned and unaligned reads

## Requirements
- Input sequence data (paired-end reads, pre-joined reads, or BAM files)
- Protein reference database (standard UniRef or custom)
- Identifier mapping file for custom databases
- Sufficient memory for database searching and pathway analysis

## Usage
```bash
source activate VEBA-profile_env
profile-pathway.py -1 forward_reads.fq -2 reverse_reads.fq -n sample_name -o output_directory -i identifier_mapping.tsv -f protein_database.faa -p threads

# Alternative input formats
# For BAM file input:
profile-pathway.py -b mapped.sorted.bam -n sample_name -o output_directory -i identifier_mapping.tsv -d diamond_database -p threads

# For pre-joined reads:
profile-pathway.py -j joined_reads.fq -n sample_name -o output_directory -i identifier_mapping.tsv -d diamond_database -p threads
```

Key parameters:
- `-1/-2`: Paired-end read files
- `-j`: Pre-joined read file
- `-b`: BAM file
- `-n`: Sample name
- `-o`: Output directory
- `-i`: Identifier mapping file
- `-f`: Protein database FASTA
- `-d`: Diamond database
- `-p`: Number of threads