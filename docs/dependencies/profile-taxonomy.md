# VEBA Profile-Taxonomy Module Dependencies

## Overview
The profile-taxonomy module performs taxonomic profiling of metagenomic samples using Sylph, a k-mer based tool. It allows researchers to profile microbiome samples against custom databases created from de novo assembled genomes or reference genomes, generating taxonomic abundance tables that can be used for downstream analyses.

## Core Python Dependencies
- **Pipeline Management**: genopype, soothsayer_utils
- **Data Processing**: pandas, numpy, scipy
- **Statistics**: statsmodels, seaborn-base
- **Utilities**: tqdm, psutil

## External Tools
- **Sylph**: Fast k-mer based tool for taxonomic profiling
- **BBMap**: Suite of bioinformatics tools for sequence data processing
- **Seqkit**: For sequence processing and statistics
- **MAFFT/Muscle**: For sequence alignment (used by Sylph when building databases)
- **FastTree/RAxML**: For phylogenetic tree construction (used by Sylph when building databases)

## Databases
- **Custom Sylph Databases**: Created from binned genomes or reference genomes
- **Genome Clusters**: Optional SLC (species-level clusters) mappings for aggregating counts

## Environment Details
The module uses the `VEBA-profile_env` conda environment (shared with other profiling modules):

### Main Packages
- python=3.10.12
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- sylph=0.4.1
- bbmap=39.01
- seqkit=2.5.1
- pandas=2.1.1
- numpy=1.26.0
- scipy=1.11.3
- tqdm=4.66.1

## Pipeline Process
1. **Sketch Generation**:
   - Creates a compact k-mer representation of input reads using Sylph sketch
   - Uses paired-end reads or accepts pre-computed sketches
   
2. **Database Profiling**:
   - Queries sketch against custom Sylph databases
   - Estimates abundance of reference genomes in the sample
   
3. **Taxonomic Assignment**:
   - Maps hits to taxonomic lineages
   - Optionally aggregates counts at the genome cluster level (SLCs)
   
4. **Output Generation**:
   - Produces gzipped TSV files with taxonomic abundance information
   - Formats results for compatibility with other analysis tools

## Requirements
- Input sequence data (paired-end reads)
- Custom Sylph databases (.syldb files)
- Optional genome-to-SLC mapping file for cluster-level aggregation
- Sufficient memory for k-mer profiling (8GB+ recommended)

## Usage
```bash
source activate VEBA-profile_env
profile-taxonomy.py -1 reads_1.fastq.gz -2 reads_2.fastq.gz -n sample_name -o output_directory -d genome_database.syldb -p threads

# With genome clusters
profile-taxonomy.py -1 reads_1.fastq.gz -2 reads_2.fastq.gz -n sample_name -o output_directory -d genome_database.syldb -c genome_to_slc.tsv -p threads

# With pre-computed sketch
profile-taxonomy.py --sketch sample.sylsk -n sample_name -o output_directory -d genome_database.syldb -p threads
```

Key parameters:
- `-1/-2`: Paired-end read files
- `--sketch`: Pre-computed Sylph sketch
- `-n`: Sample name
- `-o`: Output directory
- `-d`: Path to Sylph database(s)
- `-c`: Path to genome-to-SLC mapping file
- `-p`: Number of threads