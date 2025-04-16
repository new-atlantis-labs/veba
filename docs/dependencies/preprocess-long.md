# Preprocess-Long Module Dependencies

## Overview
The preprocess-long module in VEBA is designed for cleaning and processing long-read sequencing data, specifically Oxford Nanopore or PacBio reads. It performs quality trimming, contamination removal, k-mer based filtering, and generates comprehensive statistics at each step. This module serves as the entry point for long-read data in the VEBA workflow, preparing reads for downstream long-read assembly and analysis.

## Core Python Dependencies
- **soothsayer_utils**: Utility functions for bioinformatics pipelines
- **fastq_preprocessor_long**: Dedicated package for long-read preprocessing
- **pandas**: Data manipulation and analysis
- **tqdm**: Progress bar library

## External Tools
- **Chopper**: Quality trimming tool optimized for long reads
  - Performs quality trimming and filtering
  - Removes adapter sequences

- **Minimap2**: Fast and accurate alignment tool for long reads
  - Used for contamination screening (e.g., host DNA removal)
  - More appropriate for long-read alignment than Bowtie2

- **BBMap/BBDuk**: BBTools suite for sequence data manipulation
  - Performs k-mer based filtering (e.g., ribosomal RNA removal)
  - Supports various filtering strategies

- **seqkit**: Toolkit for FASTA/Q file manipulation
  - Generates sequence statistics
  - Performs sequence format conversions

- **Kingfisher**: Tool for downloading sequences from SRA
  - Optional component for retrieving data from public repositories

## Databases
- **Contamination databases**: Used with Minimap2 for filtering
  - Commonly includes human genome or other host sequences
  - Can be customized based on project needs

- **K-mer databases**: Used with BBDuk for filtering
  - Ribosomal RNA sequences for rRNA filtering
  - Can include other sequence types to be removed

## Environment Details
The preprocess-long module uses the `VEBA-preprocess_env` conda environment with the following key components:
- Python 3.9
- Chopper 0.7.0
- Minimap2 2.26
- BBMap 39.01
- seqkit 2.3.1
- Kingfisher 0.1.0
- SRA-tools 3.0.9 (for data retrieval)
- Other dependencies for sequence data handling and compression

## Pipeline Process
1. **Quality Trimming and Filtering** (Chopper)
   - Removes low-quality bases from reads
   - Trims adapter sequences
   - Filters reads based on length and quality scores

2. **Contamination Removal** (Minimap2)
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
- Sufficient memory for processing and alignment steps (typically more than for short reads)
- Appropriate contamination databases based on project needs
- Multi-threading capability for improved performance
- Storage space for intermediate and output files (long reads require more space)

## Usage
Basic command:
```bash
veba --module preprocess-long --params "-i long_reads.fastq.gz -n SAMPLE_ID -o output_directory -p 16"
```

Example with contamination removal and k-mer filtering:
```bash
veba --module preprocess-long --params "-i raw_nanopore.fastq.gz -n SAMPLE_ID -o veba_output/preprocess-long -p 16 -x path/to/human_genome.mmi -k path/to/rRNA_kmers.fasta --retain_contaminated_reads 0 --retain_kmer_hits 0"
```

The module outputs:
- trimmed.fastq.gz - Quality trimmed reads
- cleaned.fastq.gz - Decontaminated trimmed reads (if contamination database provided)
- non-kmer_hits.fastq.gz - Reads without hits to k-mer database (if k-mer database provided)
- seqkit_stats.concatenated.tsv - Summary statistics of preprocessing steps