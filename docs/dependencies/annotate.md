# VEBA Annotate Module Dependencies

## Overview
The annotate module provides comprehensive functional annotation for proteins, including sequence alignments, domain identification, and pathway analysis. It utilizes various databases and tools to provide detailed annotations at different levels.

## Core Python Dependencies
- **Standard Libraries**: sys, os, argparse, glob, shutil, gzip
- **Data Processing**: pandas, collections (OrderedDict, defaultdict)
- **Bioinformatics**: Biopython (Bio.SeqIO.FastaParser)
- **Workflow Management**: genopype, soothsayer_utils

## External Tools
- **Diamond**: Protein sequence alignment against multiple databases
- **PyHMMSearch**: HMM-based searches against domain databases
- **PyKofamSearch**: KO (KEGG Orthology) annotations
- **Seqkit**: Sequence preprocessing and filtering
- **pigz**: Parallel gzip compression

## Databases
- **UniRef**: Either uniref90 (for well-characterized systems) or uniref50 (for less characterized systems)
- **MIBiG**: Minimum Information about a Biosynthetic Gene cluster (v3.1)
- **VFDB**: Virulence Factor Database
- **CAZy**: Carbohydrate-Active enZYmes Database
- **Pfam**: Protein family database
- **NCBIfam-AMRFinder**: Antimicrobial resistance gene database
- **AntiFam**: Database of protein families that should not appear in a protein annotation 
- **KOfam**: KEGG Orthology database
- **KEGG Pathway**: For pathway analysis and module completion ratios

## Environment Details
The module requires a specific conda environment (`VEBA-annotate_env`):

### Main Packages
- diamond=2.1.9
- pyhmmer=0.10.12
- seqkit=2.8.2
- pigz=2.8
- biopython=1.83
- pandas=2.2.2
- numpy=1.26.4
- scipy=1.14.1
- networkx=3.3

### Custom Tools (via pip)
- kegg-pathway-profiler==2024.9.21
- pyhmmsearch==2024.10.20
- pykofamsearch==2024.11.8.post1
- pyexeggutor==2025.1.23.post2

## Pipeline Process
1. **Preprocessing**: Filter out extremely long protein sequences
2. **Diamond Search**: Against UniRef, MIBiG, VFDB, and CAZy
3. **HMM Searches**: Against Pfam, AMRFinder, and AntiFam
4. **KO Annotation**: Using PyKofamSearch against KOfam
5. **Merge Annotations**: Combine results from all searches
6. **Module Completion Ratios**: Calculate KEGG pathway coverage

## Requirements
- Protein sequences must be less than 100k in length
- Databases must be previously downloaded using the `download_databases.sh` script
- Sufficient memory to handle protein database searches

## Usage
```bash
source activate VEBA-annotate_env
annotate.py -a <proteins.faa> -o <output_directory> [options]
```