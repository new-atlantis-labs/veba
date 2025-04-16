# Mapping Module Documentation

## Overview
The mapping module aligns sequencing reads to reference sequences and generates count tables for quantitative analysis. It maps paired-end reads to reference genomes using Bowtie2 and produces count tables at various levels (ORFs, contigs, MAGs, clusters) using featureCounts. This module is essential for quantifying metagenomic or metatranscriptomic data across multiple samples.

## Core Python Dependencies
- Python 3.10+
- Pandas
- NumPy
- Biopython
- Genopype
- Soothsayer_utils
- Requests

## External Tools
- Bowtie2 (v2.5.2)
- Samtools (v1.18)
- Subread (v2.0.6, includes featureCounts)
- SeqKit (v2.6.0)
- Salmon (v0.8.1)

## Databases
- No external reference databases required
- Uses custom reference indices created from user-provided genome assemblies

## Environment Details
The mapping module operates within the VEBA-mapping_env conda environment:
```
source activate VEBA-mapping_env
```

Key package versions:
- bowtie2=2.5.2
- samtools=1.18
- subread=2.0.6
- seqkit=2.6.0
- salmon=0.8.1

## Pipeline Process
1. **Alignment with Bowtie2**
   - Maps paired-end reads to reference sequences
   - Sorts and indexes alignment (BAM) files
   - Calculates coverage statistics
   - Optionally retains unmapped reads
   - Produces genome spatial coverage when scaffold-to-bin mapping is provided

2. **Read Counting with featureCounts**
   - Generates ORF-level counts using GFF annotations
   - Generates scaffold/contig-level counts using SAF format
   - Optionally aggregates counts to:
     - Orthogroups (with proteins-to-orthogroups mapping)
     - MAGs (with scaffolds-to-bins mapping)
     - Clusters (with scaffolds-to-clusters mapping)

3. **Output Organization**
   - Creates symlinks to all relevant output files
   - Organizes BAM files, coverage data, and count tables

## Requirements
- Paired-end sequencing reads (FASTQ format)
- Reference genome index (created with the index module)
- Reference GFF and SAF files for feature counting
- Optional mapping files for aggregation (proteins_to_orthogroups.tsv, scaffolds_to_bins.tsv, scaffolds_to_clusters.tsv)

## Usage
Basic command:
```
veba --module mapping --params "-1 reads_1.fastq.gz -2 reads_2.fastq.gz -n sample_name -o output_directory -p threads -x reference_index_directory"
```

Full command with optional parameters:
```
veba --module mapping --params "-1 reads_1.fastq.gz -2 reads_2.fastq.gz -n sample_name -o output_directory -p threads -x reference_index_directory --scaffolds_to_bins scaffolds_to_bins.tsv --proteins_to_orthogroups proteins_to_orthogroups.tsv --scaffolds_to_clusters scaffolds_to_clusters.tsv"
```

Key parameters:
- `-1/--fastq_1`: Path to forward reads
- `-2/--fastq_2`: Path to reverse reads
- `-n/--name`: Sample name
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-x/--index_directory`: Directory with Bowtie2 index and annotation files
- `--scaffolds_to_bins`: File mapping scaffolds to bins (optional)
- `--proteins_to_orthogroups`: File mapping proteins to orthogroups (optional)
- `--scaffolds_to_clusters`: File mapping scaffolds to clusters (optional)