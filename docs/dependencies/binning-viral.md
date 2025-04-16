# VEBA Binning-Viral Module Dependencies

## Overview
The binning-viral module is designed to identify, extract, and verify viral sequences from metagenomic assemblies. It performs viral detection, quality assessment, gene prediction, and taxonomic classification of viral contigs. The module can also analyze read coverage when BAM files are provided. It primarily relies on geNomad for viral sequence detection and CheckV for quality assessment.

## Core Python Dependencies
- **General Utilities**: os, sys, argparse, glob, collections (OrderedDict, defaultdict)
- **Data Processing**: pandas, numpy
- **Bioinformatics**: Bio.SeqIO.FastaIO (SimpleFastaParser)
- **VEBA Ecosystem**: genopype, soothsayer_utils (for workflow management)
- **Progress Tracking**: tqdm

## External Tools
- **geNomad**: Primary tool for viral and plasmid sequence identification with machine learning models
- **CheckV**: Tool for assessing the quality and completeness of viral genomes
- **pyrodigal-gv**: Gene prediction tool specifically optimized for viral genomes
- **seqkit**: Tool for FASTA/FASTQ file manipulation (filtering, reformatting, statistics)
- **featureCounts**: Read counting tool for quantifying reads mapped to genomic features
- **Additional Scripts**:
  - filter_checkv_results.py: Filters CheckV results based on quality metrics
  - partition_gene_models.py: Separates gene models by bin/genome
  - append_geneid_to_prodigal_gff.py: Adds gene IDs to GFF files
  - genomad_taxonomy_wrapper.py: Handles taxonomic assignments for viral sequences

## Databases
- **geNomad Database**: Required for viral and plasmid detection and classification
  - Located at `[VEBA_DATABASE]/Classify/geNomad`
  - Current version used: v1.9
- **CheckV Database**: Required for viral quality assessment
  - Located at `[VEBA_DATABASE]/Classify/CheckV`
  - Current version used: v1.5

## Environment Details
The module requires a specific conda environment (`VEBA-binning-viral_env`):

### Main Packages
- genomad=1.11.0
- checkv=1.0.3
- pyrodigal-gv=0.3.2
- seqkit=2.10.0
- subread=2.0.8 (contains featureCounts)
- pandas=2.2.3
- numpy=2.2.4
- biopython=1.85

### Core Infrastructure
- genopype=2023.5.15
- soothsayer_utils=2022.6.24

## Pipeline Process
1. **Viral Sequence Identification (geNomad)**:
   - Filters input contigs by minimum length
   - Identifies viral and plasmid sequences using geNomad
   - Extracts classified viral contigs and taxonomic information

2. **Viral Quality Assessment (CheckV)**:
   - Verifies viral sequences identified by geNomad
   - Assesses completeness and quality of viral genomes
   - Filters results based on quality metrics (completeness, viral-to-host gene ratio)

3. **Gene Prediction (pyrodigal-gv)**:
   - Predicts genes in viral sequences using specialized viral gene caller
   - Generates GFF, FFN (nucleotide), and FAA (protein) files for each viral genome

4. **Read Quantification (optional)**:
   - If BAM files are provided, counts reads mapping to viral genes
   - Creates a count table of reads per viral gene

5. **Results Compilation**:
   - Organizes viral genomes, gene predictions, and annotations
   - Generates statistics for viral genomes and genes
   - Produces final output files including genome statistics and taxonomic classifications

## Requirements
- Minimum 20GB RAM recommended
- Input assembly must be in FASTA format
- Requires VEBA database with geNomad and CheckV components
- Optional: Sorted BAM file(s) for read quantification

## Usage
```bash
source activate VEBA-binning-viral_env
binning-viral.py -f <scaffolds.fasta> -n <sample_name> -o <output_directory> [options]

# With read mapping data:
binning-viral.py -f <scaffolds.fasta> -b <mapped.sorted.bam> -n <sample_name> -o <output_directory> [options]

# Using veba command wrapper:
veba --module binning-viral --params "-f <scaffolds.fasta> -n <sample_name> -o <output_directory> -p <threads> -m <min_length> --veba_database <database_path>"
```

### Key Parameters
- `-f, --fasta`: Path to assembly FASTA file
- `-n, --name`: Sample name (used for output naming)
- `-b, --bam`: (Optional) Path to sorted BAM file(s) for read mapping
- `-m, --minimum_contig_length`: Minimum contig length to consider (default: 1500)
- `-p, --n_jobs`: Number of threads to use (default: 1)
- `--include_provirus_detection`: Enable provirus detection (default: disabled)
- `--checkv_completeness`: Minimum viral genome completeness (default: 50.0)
- `--checkv_quality`: Required quality levels (default: "High-quality,Medium-quality,Complete")