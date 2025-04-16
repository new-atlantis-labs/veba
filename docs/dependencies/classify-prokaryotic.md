# VEBA Classify-Prokaryotic Module Dependencies

## Overview
The classify-prokaryotic module provides taxonomic classification of prokaryotic genomes (MAGs) recovered from metagenomic data using GTDB-Tk. It identifies the placement of input genomes in the Genome Taxonomy Database (GTDB) reference tree and assigns taxonomy based on evolutionary relationships.

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Data Processing**: pandas, numpy
- **Phylogenetic Analysis**: dendropy
- **Utilities**: tqdm, psutil

## External Tools
- **GTDB-Tk**: Main tool for genome taxonomy classification
- **FastANI**: Tool for calculating average nucleotide identity
- **Mash**: Tool for genomic distance estimation
- **Skani**: Tool for fast ANI calculation
- **Prodigal**: Gene prediction tool used by GTDB-Tk
- **HMMER**: Used for marker gene identification
- **FastTree**: Phylogenetic tree construction
- **Pplacer**: Phylogenetic placement algorithm
- **Krona**: Tool for interactive visualization of taxonomic hierarchies

## Databases
- **GTDB Database**: Genome Taxonomy Database reference data
- **GTDB Mash Database**: Pre-computed Mash sketches for ANI screening

## Environment Details
The module requires a specific conda environment (`VEBA-classify-prokaryotic_env`):

### Main Packages
- python=3.8.19
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- gtdbtk=2.4.0
- fastani=1.32
- mash=2.3
- skani=0.2.1
- prodigal=2.6.3
- hmmer=3.4
- fasttree=2.1.11
- pplacer=1.1.alpha19
- pandas=2.0.3
- numpy=1.24.4
- dendropy=5.0.1
- krona=2.8.1
- tqdm=4.66.4

## Pipeline Process
1. **Genome Collection**: 
   - Collects prokaryotic genomes from binning output or a provided list
   - Copies and organizes genomes for processing

2. **GTDB-Tk Classification**:
   - Identifies marker genes in genomes using Prodigal and HMMER
   - Places genomes in the GTDB reference tree using pplacer
   - Assigns taxonomy based on phylogenetic placement
   - Optionally performs ANI screening to refine classification

3. **Result Processing**:
   - Combines archaea and bacteria classification results
   - Generates taxonomy tables in standard format

4. **Visualization**:
   - Creates Krona plots for interactive visualization of taxonomic distributions

5. **Cluster Classification** (optional):
   - If genome clusters are provided, performs consensus classification at the cluster level
   - Uses a weighted approach to determine the most representative taxonomy for each cluster

## Requirements
- Prokaryotic genome bins (MAGs) in FASTA format
- GTDB database installed in the VEBA_DATABASE directory
- Sufficient memory for GTDB-Tk analysis (minimum 100GB RAM recommended)

## Usage
```bash
source activate VEBA-classify-prokaryotic_env
veba --module classify-prokaryotic --params "-i veba_output/binning/prokaryotic/ -o veba_output/classify/prokaryotic -p 16"

# With genome clusters
veba --module classify-prokaryotic --params "-i veba_output/binning/prokaryotic/ -c veba_output/cluster/output/global/mags_to_slcs.tsv -o veba_output/classify/prokaryotic -p 16"

# With specific genomes list
veba --module classify-prokaryotic --params "-g genomes.list -o veba_output/classify/prokaryotic -p 16 --skip_ani_screen"
```

Key parameters:
- `-i/--prokaryotic_binning_directory`: Directory from prokaryotic binning module
- `-g/--genomes`: Path to genomes file list (alternative to -i)
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `-c/--clusters`: Path to genome-to-cluster mapping file
- `-l/--leniency`: Weight for higher taxonomic ranks in cluster classification (default: 1.382)
- `--skip_ani_screen`: Option to skip ANI screening step for faster classification