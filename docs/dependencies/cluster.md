# VEBA Cluster Module Dependencies

## Overview
The cluster module in VEBA is responsible for clustering genomes and their proteins to identify species-level clusters (SLCs) and species-specific protein clusters (SSPCs). It performs both genome-level clustering using nucleotide identity metrics (ANI/AF) and protein-level clustering based on sequence similarity. The module enables comparative genomics by identifying genome pangenomes, core genomes, and singleton clusters across samples.

## Core Python Dependencies
- **Workflow Management**: genopype (pipeline framework)
- **Utility**: soothsayer_utils (computational biology utilities)
- **Data Analysis**: pandas, numpy (data manipulation and analysis)
- **Sequence Processing**: biopython (biological sequence handling)
- **Network Analysis**: networkx (graph modeling for clustering)

## External Tools
- **Genome Clustering**:
  - skani: Ultra-fast ANI calculation tool optimized for both prokaryotes and viruses
  - FastANI: Fast alignment-free computation of whole-genome Average Nucleotide Identity
  
- **Protein Clustering**:
  - MMseqs2: Fast and sensitive protein clustering tool
  - Diamond: Fast sequence aligner for protein and translated DNA searches

- **Supporting Tools**:
  - edgelist_to_clusters.py: Converts pairwise ANI/AF relationships to clusters
  - global_clustering.py: Clustering genomes across all samples
  - local_clustering.py: Clustering genomes within individual samples
  - clustering_wrapper.py: Wrapper for protein clustering tools

## Databases
- No specific reference databases are required for this module

## Environment Details
The module requires the `VEBA-cluster_env` conda environment:

### Main Packages
- Python 3.11
- skani 0.2.1
- FastANI 1.34
- MMseqs2 14.7e284
- Diamond 2.1.8
- networkx 3.0
- pandas 1.5.3
- numpy 1.24.1
- biopython 1.80

## Pipeline Process
1. **Global Clustering**:
   - Takes a genomes table as input with organism types, sample IDs, MAG IDs, genomes, proteins, and CDS
   - Organizes genomes by organism type (prokaryotic, eukaryotic, viral)
   - Computes pairwise ANI and alignment fractions between genomes using skani or FastANI
   - Creates species-level clusters (SLCs) based on configurable ANI and alignment fraction thresholds
   
2. **Protein Clustering**:
   - For each genome cluster, extracts all proteins from member genomes
   - Performs protein clustering using MMseqs2 or Diamond with configurable identity and coverage thresholds
   - Creates species-specific protein clusters (SSPCs)
   - Identifies representative sequences for each protein cluster
   
3. **Pangenome Analysis**:
   - Creates prevalence tables for each genome cluster showing the distribution of protein clusters
   - Identifies core protein clusters (present in all genomes in a cluster)
   - Identifies singleton protein clusters (present in only one genome)
   - Calculates feature compression ratios to quantify redundancy reduction
   
4. **Output Generation**:
   - Produces identifier mappings for genomes, scaffolds, and proteins
   - Generates representative protein sequences
   - Creates pangenome tables
   - Provides serialized graph objects for network analysis
   - Supports both global (across all samples) and local (per-sample) clustering modes

## Requirements
- Sufficient memory for large datasets with many genomes
- Computing power for ANI calculations which can be resource-intensive
- Multi-threading capability for improved performance
- Storage space for intermediate and output files

## Usage
Global clustering:
```bash
source activate VEBA-cluster_env
veba --module cluster --params "-i genomes_table.tsv -o veba_output/cluster -p 16"
```

Local clustering (within each sample):
```bash
source activate VEBA-cluster_env
veba --module cluster --params "-i genomes_table.tsv -o veba_output/cluster -p 16 -l"
```

Advanced usage with custom thresholds:
```bash
source activate VEBA-cluster_env
veba --module cluster --params "-i genomes_table.tsv -o veba_output/cluster -p 16 -G skani -A 95.0 -F 50.0 -P mmseqs-cluster -t 50.0 -c 0.8"
```