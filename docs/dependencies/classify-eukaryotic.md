# VEBA Classify-Eukaryotic Module Dependencies

## Overview
The classify-eukaryotic module provides taxonomic classification of eukaryotic genomes (MAGs) recovered from metagenomic data. It uses protein homology-based approaches to classify eukaryotic genomes by identifying core markers and mapping proteins to known eukaryotic references from the MicroEuk database.

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Data Processing**: pandas, numpy
- **Sequence Analysis**: biopython, pyhmmsearch, pyhmmer
- **Utilities**: tqdm, psutil

## External Tools
- **MetaEuk**: Fast toolkit for eukaryotic gene prediction and homology-based annotation
- **HMMER/pyhmmer**: Tools for searching sequence databases for sequence homologs
- **SeqKit**: Cross-platform toolkit for FASTA/Q file manipulation
- **Krona**: Tool for interactive visualization of taxonomic hierarchies

## Databases
- **MicroEuk**: Database of curated eukaryotic protein sequences
- **Eukaryota_odb10**: BUSCO core marker genes for eukaryotes
- **Taxonomic Mapping Resources**: Files mapping proteins to taxonomic lineages

## Environment Details
The module requires a specific conda environment (`VEBA-classify-eukaryotic_env`):

### Main Packages
- python=3.12.3
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- metaeuk=7.bba0d80
- pyhmmer=0.10.12
- pyhmmsearch=2024.10.20
- pandas=2.2.2
- numpy=1.26.4
- biopython=1.83
- seqkit=2.8.2
- krona=2.8.1
- tqdm=4.66.4

## Pipeline Process
1. **Preprocessing**: 
   - Prepares input data from eukaryotic binning output, custom genomes, or pre-computed MetaEuk results
   - Creates mappings of scaffolds to bins (genomes)

2. **Core Marker Identification**:
   - Identifies eukaryotic BUSCO markers in protein sequences
   - Filters proteins hits based on score cutoffs

3. **Classification Compilation**:
   - Maps proteins to taxonomic sources using the MicroEuk database
   - Generates gene-source lineage information with confidence scores

4. **Consensus Classification**:
   - Creates a consensus taxonomy for each genome based on protein classifications
   - Uses a weighted approach that differentially considers various taxonomic levels

5. **Visualization**:
   - Creates Krona plots for interactive visualization of taxonomic distributions

6. **Cluster Classification** (optional):
   - If genome clusters are provided, generates consensus classifications at the cluster level

## Requirements
- Eukaryotic genome bins (MAGs) in FASTA format
- VEBA databases installed (especially MicroEuk and BUSCO markers)
- Optional genome-to-cluster mapping for cluster-level classification

## Usage
```bash
source activate VEBA-classify-eukaryotic_env
veba --module classify-eukaryotic --params "-i veba_output/binning/eukaryotic/ -o veba_output/classify/eukaryotic -p 4"

# With genome clusters
veba --module classify-eukaryotic --params "-i veba_output/binning/eukaryotic/ -c veba_output/cluster/output/global/mags_to_slcs.tsv -o veba_output/classify/eukaryotic -p 4"

# With specific genomes list
veba --module classify-eukaryotic --params "-g genomes.list -o veba_output/classify/eukaryotic -p 4 --minimum_bin_confidence 0.2"
```

Key parameters:
- `-i/--input_directory`: Directory from eukaryotic binning module
- `-g/--genomes`: Path to genomes file list
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-c/--clusters`: Path to genome-to-cluster mapping file
- `--minimum_bin_confidence`: Minimum confidence score for classification (default: 0.5)
- `--leniency`: Weight for higher taxonomic ranks (default: 1.382)