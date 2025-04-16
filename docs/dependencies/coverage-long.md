# Coverage-Long Module Documentation

## Overview
The coverage-long module in VEBA processes long read mapping to reference sequences (contigs/scaffolds) and calculates coverage statistics. This specialized version is optimized for long reads from technologies like Oxford Nanopore or PacBio. The module generates critical coverage information necessary for binning and quantification in metagenomic analyses of long-read data.

## Core Python Dependencies
- pandas
- genopype (VEBA's workflow framework)
- soothsayer_utils

## External Tools
- minimap2 (for long read mapping)
- samtools
- featureCounts
- seqkit
- GNU parallel

## Databases
- No external reference databases required

## Environment Details
The coverage-long module operates within the VEBA-assembly_env conda environment:
```
source activate VEBA-assembly_env
```

## Pipeline Process
1. **Index**
   - Filter reference sequences by minimum length
   - Create SAF file for featureCounts
   - Build minimap2 index for long read mapping
   - Generate reference sequence statistics

2. **Alignment**
   - Map long reads to reference sequences using minimap2
   - Configure mapping with appropriate preset based on sequencing technology (map-ont, map-pb, map-hifi)
   - Sort and index resulting BAM files

3. **Read Counting**
   - Count reads mapped to each feature using featureCounts
   - Generate a consolidated counts table across samples
   - Compress output files

4. **Output Organization**
   - Create symbolic links to relevant output files

## Requirements
- Long reads in FASTQ format with a 2-column TSV file listing sample IDs and read files
- Reference sequences in FASTA format

## Usage
```
veba --module coverage-long --params "-f reference.fasta -r reads.tsv -o output_directory -p threads --minimap2_preset map-ont"
```

### Key Parameters
- `-f/--fasta`: Reference FASTA file
- `-r/--reads`: Reads table TSV file (2-column: sample ID, read file)
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-m/--minimum_contig_length`: Minimum contig length (default: 1)
- `--minimap2_preset`: Preset for long reads (map-pb, map-ont, map-hifi; default: map-ont)