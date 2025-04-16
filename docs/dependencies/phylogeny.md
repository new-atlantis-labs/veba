# VEBA Phylogeny Module Dependencies

## Overview
The phylogeny module constructs phylogenetic trees from protein sequences using marker genes. It identifies marker proteins using HMM profiles, performs multiple sequence alignment, and builds phylogenetic trees to infer evolutionary relationships between genomes.

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Sequence Analysis**: biopython, pyhmmsearch, pyhmmer
- **Data Processing**: pandas, numpy, scipy
- **Visualization**: ete3
- **Utilities**: tqdm (progress tracking), psutil

## External Tools
- **MUSCLE**: Performs multiple sequence alignment
- **ClipKIT**: Trims and filters alignments to remove poorly aligned regions
- **FastTree/VeryFastTree**: Constructs phylogenetic trees using approximate maximum likelihood
- **IQTree**: Builds phylogenetic trees using maximum likelihood methods
- **GNU Parallel**: Enables parallelization of tasks

## Databases
- **HMM Marker Databases**: Hidden Markov Model profiles of marker genes/proteins for identification

## Environment Details
The module requires a specific conda environment (`VEBA-phylogeny_env`):

### Main Packages
- python=3.12.3
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- biopython=1.83
- pandas=2.2.2
- muscle=5.1
- clipkit=2.3.0
- fasttree=2.1.11
- veryfasttree=4.0.03
- iqtree=2.3.4
- pyhmmer=0.10.12
- pyhmmsearch=2024.10.20
- ete3=3.1.3
- parallel=20240522

## Pipeline Process
1. **Preprocessing**: Processes input protein files and creates symlinks for efficient data access
2. **PyHMMSearch**: Identifies marker proteins from the input sequences using HMM profiles
3. **Multiple Sequence Alignment (MSA)**: Aligns identified marker sequences using MUSCLE
4. **Alignment Trimming**: Trims alignments using ClipKIT to remove poorly aligned regions
5. **Tree Construction**: Builds phylogenetic trees using FastTree/VeryFastTree or IQTree
6. **Tree Visualization**: Renders phylogenetic trees using ETE3

## Requirements
- Input protein sequences in FASTA format
- HMM database of marker genes/proteins
- Optional score cutoffs for marker identification
- Sufficient memory for alignment and tree construction (especially for large datasets)

## Usage
```bash
source activate VEBA-phylogeny_env
veba --module phylogeny --params "-a proteins.list -o output_directory -p 16 -d marker_database.hmm -s scores_cutoff.tsv"
```

Key parameters:
- `-a/--proteins`: Path to list of protein FASTA files
- `-d/--database`: Path to HMM database for marker genes
- `-s/--scores`: Optional path to score cutoffs table
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of threads
- `--minimum_alignment_fraction`: Minimum fraction of alignment that must be present
- `--minimum_representation_taxon`: Minimum fraction of taxa that must have a marker
- `--minimum_representation_marker`: Minimum fraction of markers a taxon must have
- `--algorithm`: Alignment algorithm (align, super5)
- `--tree_program`: Tree construction program (veryfasttree, fasttree, iqtree)