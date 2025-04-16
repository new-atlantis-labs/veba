# Classify-Viral Module Dependencies

## Overview
The Classify-Viral module taxonomically classifies viral genomes (MAGs) using geNomad, a deep learning-based tool for viral genome detection and taxonomy assignment.

## Core Python Dependencies
- pandas: Data manipulation and analysis
- numpy: Numerical computing
- soothsayer_utils: Utility functions for bioinformatics
- genopype: Pipeline management framework

## External Tools
- geNomad v1.11.0: Viral sequence identification and taxonomy assignment 
- seqkit: FASTA/Q sequence manipulation
- xgboost: Gradient boosting framework (used by geNomad)
- tensorflow: Machine learning library (used by geNomad)

## Databases
- geNomad database: Located at `$VEBA_DATABASE/Classify/geNomad`
  - Contains marker sequences and taxonomy reference data

## Environment Details
The module uses the Conda environment specified in `VEBA-classify-viral_env.yml`:
```
name: VEBA-classify-viral_env__v2025.4.4
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - geNomad=1.11.0
  - pandas
  - numpy
  - seqkit
  - xgboost
  - tensorflow
  - pip
  - pip:
    - soothsayer_utils
    - genopype
```

## Pipeline Process
1. **Input Processing**:
   - Processes input viral genomes from either the viral binning module output or a custom list
   - Handles CheckV results if available

2. **Taxonomy Classification**:
   - Uses geNomad's `annotate` command to identify and classify viral sequences
   - Applies confidence thresholds for taxonomic assignments

3. **Result Formatting**:
   - Generates standardized taxonomy tables with lineage information
   - Creates optional consensus classifications for genome clusters
   - Formats output for compatibility with downstream VEBA modules

## Requirements
- Input files must be in FASTA format
- Database must be installed via `download_databases-classify.sh` before use
- Requires at least 16GB RAM for the geNomad classification step

## Usage
```bash
# Basic usage with viral binning directory
veba --module classify-viral --params="-i /path/to/viral_binning_dir -o /path/to/output -p 8 --veba_database /path/to/VEBA_DATABASE"

# Using genome list directly
veba --module classify-viral --params="-g /path/to/genomes.list -o /path/to/output -p 8 --veba_database /path/to/VEBA_DATABASE"

# With genome clusters for consensus classification
veba --module classify-viral --params="-i /path/to/viral_binning_dir -c /path/to/clusters.tsv -o /path/to/output -p 8 --veba_database /path/to/VEBA_DATABASE"
```