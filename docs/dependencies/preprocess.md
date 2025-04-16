# Preprocess Module Dependencies

## Overview
The preprocess module in VEBA is responsible for cleaning and processing raw sequencing reads, specifically paired-end Illumina data. It performs adapter/quality trimming, contamination removal, k-mer based filtering, and generates comprehensive statistics at each step. This module is typically the first step in the VEBA workflow, preparing reads for downstream assembly and analysis.

## Core Python Dependencies
- **soothsayer_utils**: Utility functions for bioinformatics pipelines
- **fastq_preprocessor**: Dedicated package for read preprocessing
- **pandas**: Data manipulation and analysis
- **tqdm**: Progress bar library

## External Tools
- **fastp**: Fast all-in-one preprocessing for FASTQ files
  - Performs quality trimming, adapter removal, and filtering
  - Generates quality reports

- **Bowtie2**: Fast and sensitive read alignment tool
  - Used for contamination screening (e.g., host DNA removal)
  - Maps reads against reference databases

- **BBMap/BBDuk**: BBTools suite for sequence data manipulation
  - Performs k-mer based filtering (e.g., ribosomal RNA removal)
  - Supports various filtering strategies

- **seqkit**: Toolkit for FASTA/Q file manipulation
  - Generates sequence statistics
  - Performs sequence format conversions

- **Kingfisher**: Tool for downloading sequences from SRA
  - Optional component for retrieving data from public repositories

## Databases
- **Contamination databases**: Used with Bowtie2 for filtering
  - Commonly includes human genome or other host sequences
  - Can be customized based on project needs

- **K-mer databases**: Used with BBDuk for filtering
  - Ribosomal RNA sequences for rRNA filtering
  - Can include other sequence types to be removed

## Environment Details
The preprocess module uses the `VEBA-preprocess_env` conda environment with the following key components:
- Python 3.9
- fastp 0.23.4
- Bowtie2 2.5.1
- BBMap 39.01
- seqkit 2.3.1
- Kingfisher 0.1.0
- SRA-tools 3.0.9 (for data retrieval)
- Other dependencies for sequence data handling and compression

## Pipeline Process
1. **Quality Trimming and Adapter Removal** (fastp)
   - Removes low-quality bases from reads
   - Trims adapter sequences
   - Generates quality reports

2. **Contamination Removal** (Bowtie2)
   - Aligns reads against contamination database
   - Filters out reads matching contamination sequences
   - Can retain or discard contaminated reads based on settings

3. **K-mer Based Filtering** (BBDuk)
   - Compares reads against a k-mer database
   - Removes reads matching unwanted sequences (e.g., rRNA)
   - Can retain or discard matching reads based on settings

4. **Statistics Generation** (seqkit)
   - Computes statistics at each processing stage
   - Tracks read counts, lengths, quality scores, etc.
   - Provides comprehensive view of preprocessing impacts

## Requirements
- Sufficient memory for processing and alignment steps
- Appropriate contamination databases based on project needs
- Multi-threading capability for improved performance
- Storage space for intermediate and output files

## Usage
Basic command:
```bash
veba --module preprocess --params "-1 forward_reads.fastq.gz -2 reverse_reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16"
```

Example with contamination removal and k-mer filtering:
```bash
veba --module preprocess --params "-1 raw_1.fastq.gz -2 raw_2.fastq.gz -n SAMPLE_ID -o veba_output/preprocess -p 16 -x path/to/human_genome_index -k path/to/rRNA_kmers.fasta --retain_contaminated_reads 0 --retain_kmer_hits 0"
```

The module outputs:
- cleaned_1.fastq.gz, cleaned_2.fastq.gz - Processed reads ready for assembly
- seqkit_stats.concatenated.tsv - Summary statistics of preprocessing steps