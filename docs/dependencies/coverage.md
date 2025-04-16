# Coverage Module Documentation

## Overview
The coverage module in VEBA processes read mapping to reference sequences (contigs/scaffolds) and calculates coverage statistics. It exists in two variants: the standard version for short reads and a specialized version (coverage-long) for long reads. This module is critical for generating coverage information necessary for binning and quantification in metagenomic analyses.

## Core Python Dependencies
- pandas
- genopype (VEBA's workflow framework)
- soothsayer_utils

## External Tools
- bowtie2/bowtie2-build (for short reads)
- minimap2 (for long reads)
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
   - Build appropriate index (bowtie2 or minimap2)
   - Generate reference sequence statistics

2. **Alignment**
   - Map reads to reference sequences
   - For short reads: Use bowtie2 for paired-end reads
   - For long reads: Use minimap2 with configurable presets
   - Sort and index resulting BAM files

3. **Read Counting**
   - Count reads mapped to each feature using featureCounts
   - Generate a consolidated counts table across samples
   - Compress output files

4. **Output Organization**
   - Create symbolic links to relevant output files

## Requirements
- **Short reads mode**: Paired-end reads in FASTQ format with a 3-column TSV file listing sample IDs and read files
- **Long reads mode**: Long reads in FASTQ format with a 2-column TSV file listing sample IDs and read files
- Reference sequences in FASTA format

## Usage
### Short Reads
```
veba --module coverage --params "-f reference.fasta -r reads.tsv -o output_directory -p threads"
```

### Long Reads
```
veba --module coverage-long --params "-f reference.fasta -r reads.tsv -o output_directory -p threads --minimap2_preset map-ont"
```

### Key Parameters
- `-f/--fasta`: Reference FASTA file
- `-r/--reads`: Reads table TSV file
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-m/--minimum_contig_length`: Minimum contig length (default: 1)
- `--minimap2_preset`: Preset for long reads (map-pb, map-ont, map-hifi; default: map-ont)