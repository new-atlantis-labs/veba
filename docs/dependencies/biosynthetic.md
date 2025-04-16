# Biosynthetic Module Dependencies

## Overview
The biosynthetic module identifies and analyzes biosynthetic gene clusters (BGCs) in prokaryotic and eukaryotic genomes. It leverages antiSMASH for BGC detection, calculates novelty scores, performs homology searches against reference databases, and clusters similar BGCs.

## Core Python Dependencies
- genopype (workflow management)
- soothsayer_utils
- pandas
- BioPython
- tqdm

## External Tools
- antiSMASH v7.1.0 (core BGC detection)
- DIAMOND v2.1.11 (sequence homology searches)
- MMSEQS2 v17.b804f (sequence clustering)
- Krona v2.8.1 (visualization)
- HMMER v3.1b2 (protein family identification)

## Databases
- MIBiG v3.1 (Minimum Information about a Biosynthetic Gene cluster)
- VFDB (Virulence Factor Database)
- antiSMASH databases

## Environment Details
The module uses the VEBA-biosynthetic_env conda environment which includes all necessary dependencies. Key components include:
- Python 3.11
- antiSMASH 7.1.0
- DIAMOND 2.1.11
- MMSEQS2 17.b804f
- HMMER 3.1b2
- Krona 2.8.1

## Pipeline Process
1. **Input Processing**: Accepts tables of genomes with corresponding gene models
2. **antiSMASH Analysis**: Detects biosynthetic gene clusters and generates detailed annotations
3. **BGC Identification**: Processes antiSMASH results and extracts BGC information
4. **Homology Searches**: Uses DIAMOND to find similar BGCs in MIBiG and VFDB databases
5. **Novelty Scoring**: Calculates novelty scores based on homology search results
6. **Clustering**: Optional clustering of BGCs at protein and nucleotide levels using MMSEQS2
7. **Visualization**: Generates Krona plots showing distribution of BGC types

## Usage
```bash
# Compile genome table
compile_genomes_table.py -i veba_output/binning/ | grep "^prokaryotic" | cut -f3,4,7 > veba_output/misc/genomes_gene-models.tsv

# Run biosynthetic module
source activate VEBA
veba --module biosynthetic --params "-i veba_output/misc/genomes_gene-models.tsv -o veba_output/biosynthetic/prokaryotic -p 16 -t bacteria"
```

### Key Parameters
- `-i/--from_genomes`: Path to table with genome info
- `-A/--from_antismash`: Alternative input for existing antiSMASH results
- `-o/--output_directory`: Output directory
- `-p/--n_jobs`: Number of CPU threads
- `-t/--taxon`: Taxonomic classification (bacteria/fungi)
- `--protein_minimum_identity_threshold`: Protein clustering identity threshold (default: 50.0)
- `--nucleotide_minimum_identity_threshold`: Nucleotide clustering identity threshold (default: 90.0)