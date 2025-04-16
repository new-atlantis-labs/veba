# VEBA Index Module Dependencies

## Overview
The index module prepares reference sequences for mapping by concatenating FASTA files and gene models (GFF files), and building Bowtie2 indexes. It supports both global mode (single concatenated reference and index) and local mode (individual references and indexes per sample).

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Data Processing**: pandas, biopython
- **Utilities**: tqdm (progress tracking)

## External Tools
- **Bowtie2-build**: Creates indexes for reference sequences used in read mapping
- **SeqKit**: Performs sequence manipulation and processing tasks

## Databases
- No external reference databases required
- Uses user-provided FASTA files and GFF annotations

## Environment Details
The module uses the VEBA-mapping environment (`VEBA-mapping_env`):

### Main Packages
- python=3.10.13
- bowtie2=2.5.2
- biopython=1.81
- pandas=2.1.3
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- seqkit=2.6.0

## Pipeline Process
1. **Concatenate FASTA files**: Combines reference sequences into a single FASTA file, creates SAF files for feature counting, and generates ID-to-hash mapping tables
2. **Concatenate GFF files**: Combines gene model annotations into a single GFF file
3. **Build Bowtie2 index**: Creates Bowtie2 indexes for the references (supports both gzipped and uncompressed FASTA)

## Requirements
- Input reference sequences must be in FASTA format (gzipped or uncompressed)
- Gene models must be in GFF format
- Sufficient disk space for concatenated files and index files

## Usage
```bash
source activate VEBA-mapping_env
veba --module index --params "-r references.list -g gene_models.list -o output_directory -p threads -M mode"
```

Key parameters:
- `-r/--references`: Path to reference sequences file list
- `-g/--gene_models`: Path to gene model file list
- `-o/--output_directory`: Output directory
- `-m/--minimum_contig_length`: Minimum contig length (default: 1)
- `-M/--mode`: Mode for indexing (global, local, or infer)
- `-p/--n_jobs`: Number of threads