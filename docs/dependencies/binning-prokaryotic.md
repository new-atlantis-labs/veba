# VEBA Binning-Prokaryotic Module Dependencies

## Overview
The binning-prokaryotic module is responsible for recovering prokaryotic genomes from metagenomic assemblies. It implements multiple binning algorithms (MetaBat2, SemiBin2, MetaDecoder, MetaCoAG, VAMB) and integrates them through Binette for refinement and quality assessment. The module processes assembled contigs along with their coverage information to cluster them into putative genomes (bins), followed by quality assessment, domain classification, and annotation of tRNA and rRNA genes.

## Core Python Dependencies
- **General Utilities**: sys, os, argparse, glob, random, warnings, collections (OrderedDict, defaultdict)
- **Data Manipulation**: pandas, numpy
- **Pipeline Framework**: genopype, soothsayer_utils
- **Custom Scripts**: Several custom utility scripts for bin manipulation, coverage conversion, and annotation

## External Tools
- **Binning Algorithms**:
  - **MetaBat2**: Recovers genomes using tetranucleotide frequencies and abundance
  - **SemiBin2**: Deep learning-based binning with pre-trained models for different environments
  - **MetaDecoder**: Marker-based binning using HMMs and clustering
  - **MetaCoAG**: Graph-based binning that incorporates assembly graph structure
  - **VAMB**: Variational autoencoder for metagenomic binning
- **Bin Refinement**:
  - **Binette**: Refines and evaluates bins using CheckM2 for quality assessment
- **Domain Classification**:
  - **Tiara**: Classifies contigs into prokaryotic/eukaryotic domains
- **Sequence Annotation**:
  - **Pyrodigal**: Gene prediction for prokaryotic sequences
  - **barrnap**: rRNA gene prediction
  - **tRNAscan-SE**: tRNA gene prediction
- **Read Mapping & Coverage**:
  - **CoverM**: Calculates coverage statistics from BAM files
  - **featureCounts**: Counts mapped reads for gene features
- **Sequence Utilities**:
  - **SeqKit**: General sequence manipulation and statistics

## Databases
- **CheckM2 Database**: Used for quality assessment (`checkm2_db`, located at `/veba_database/Classify/CheckM2/uniref100.KO.1.dmnd`)

## Environment Details
The module requires a specific conda environment (`VEBA-binning-prokaryotic_env`):

### Main Packages
- binette=1.1.1
- barrnap=0.9
- coverm=0.7.0
- checkm2=1.1.0
- metabat2=2.17
- semibin=2.2.0
- trnascan-se=2.0.12
- seqkit=2.10.0
- pyrodigal=3.6.3
- tiara=1.0.4
- metacoag=1.2.3
- metadecoder=1.1.1
- vamb=5.0.3
- subread=2.0.8 (for featureCounts)
- pandas=2.2.3
- genopype=2023.5.15
- soothsayer_utils=2022.6.24
- tensorflow=2.17.0

## Pipeline Process
1. **Coverage Calculation**: Uses CoverM to generate coverage profiles from BAM files for each binning algorithm
2. **Gene Prediction**: Employs Pyrodigal for gene prediction on all input contigs
3. **Binning Execution**:
   - Runs multiple binning algorithms in parallel (MetaBat2, SemiBin2, MetaDecoder, MetaCoAG, VAMB)
   - Each algorithm clusters contigs into bins based on sequence composition and coverage
4. **Bin Refinement**:
   - Binette integrates and refines bins from all algorithms
   - CheckM2 assesses genome quality (completeness/contamination)
   - Quality filtering removes low-quality bins
5. **Domain Classification**:
   - Tiara classifies bins as prokaryotic or eukaryotic
   - Eukaryotic bins are identified and separated
6. **RNA Gene Detection**:
   - barrnap identifies ribosomal RNA genes
   - tRNAscan-SE identifies transfer RNA genes
7. **Read Quantification**:
   - featureCounts quantifies reads mapping to predicted genes
8. **Result Consolidation**:
   - Compiles final bins with quality metrics
   - Generates comprehensive statistics (genome sizes, gene counts)
   - Creates output files including genome FASTA, GFF, and quality reports

## Requirements
- Minimum 8GB RAM, recommended 16GB+ for larger datasets
- Sufficient storage space for intermediate files
- GPU acceleration optional for SemiBin2 and VAMB (significantly speeds up computation)
- BAM files must be coordinate-sorted and indexed
- Minimum contig length of 1500bp recommended
- May require custom configuration for MetaCoAG if using MEGAHIT assemblies

## Usage
```bash
source activate VEBA-binning-prokaryotic_env
veba --module binning-prokaryotic --params "-f scaffolds.fasta -b mapped.sorted.bam -n sample_name -o output_directory -p 16 -a metabat2,semibin2-global,metadecoder,vamb"
```

Basic command structure:
```bash
binning-prokaryotic.py -f scaffolds.fasta -b mapped.sorted.bam -n sample_name -o output_directory -p 16 -a metabat2,semibin2-global,metadecoder,vamb
```

The module supports multiple binning algorithms that can be specified with the `-a` parameter. For SemiBin2, environment-specific models can be selected with syntax like `semibin2-human_gut`.