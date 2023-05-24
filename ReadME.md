# OKseq pipeline

## [Replication Program and Genome Instability Team](https://institut-curie.org/team/chen)

# Table of Contents

* [General Information](#General-Information)
* [Requirements](#Requirements)
* [Run](#Run)
* [References](#References)

# General Information

- This is a first version implementation of an analysis pipeline for OK Seq data using [OKseqHMM](https://github.com/CL-CHEN-Lab/OK-Seq).

## Folder Organisation

```
     └───config
            └───config.yaml
     └───OKseq
            └───OKseqHMM.R         
            └───heatmapOEM.smk              
            └───plotOEMheatmap.smk
            └───OKseqOEM.R           
            └───heatmapRFD.smk              
            └───plotRFDprofile.smk
            └───averageRFDprofile.smk       
            └───hmm.smk                     
            └───wig2bigwig.smk
            └───bedGraphToBigWig     
            └───oem.smk                     
            └───wigToBigWig
            └───bedgraph2bw.smk             
            └───plotHeatmapRFD.smk
     └───Reference
            └───hg19
                └───Chr_Sizes
                            └───hg19.chrom.sizes
                └───Coding_Genes
                            └───coding_genes.hg19.bed
     └───OKseq.smk
```

## Config

- Please take a look at the **config.yaml** file before running the pipeline.
- You should specify the path to the directory containing your **BAM** folder. The latter should be named **BAM**.
- You should specify your sample names as well.
- You can change the number of threads and other parameters related to the OKseqHMM package.

# Requirements

- [R (>=3.1.0)](https://www.r-project.org/)	
	- HMM
	- Rsamtools
	- GenomicAlignments	
- [Python 3](https://www.python.org/downloads/)
	- [deeptools](https://deeptools.readthedocs.io/en/develop/)
- [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)

# Run

- To run the pipeline type the following command:

```
snakemake -c {Number of Threads} -s OKseq.smk
```

# References

Petryk N., Kahli M., d'Aubenton-Carafa Y., Jaszczsyzyn Y., Shen Y., Sylvain M., Thermes C., CHEN C.L.#, and Hyrien O.# (#co-last authors). Replication landscape of the human genome. ***Nat. Commun.*** 7:10208 (2016). https://doi.org/10.1038/ncomms10208

Promonet A.\*, Padioleau I.\*, LIU Y.\* (\*co-first authors), Sanz L., Schmitz A., Skrzypczak M., Sarrazin A., Ginalski K., Chedin F., Rowicka  M., CHEN C.L.#, Lin Y.L.# and Pasero P.# (#co-last authors). Topoisomerase 1 prevents R-loop mediated replication stress at transcription termination sites. ***Nat. Commun.*** 11:3940 (2020) https://doi.org/10.1038/s41467-020-17858-2

Liu, Y., Wu, X., D'Aubenton-Carafa, Y., Thermes, C. & Chen, C.-L. OKseqHMM: a genome-wide replication fork directionality analysis toolkit. ***Nucleic Acids Research*** (2023) https://doi.org/10.1093/nar/gkac1239

Wu, X., Liu, Y., d’Aubenton-Carafa, Y. et al. Genome-wide measurement of DNA replication fork directionality and quantification of DNA replication initiation and termination with Okazaki fragment sequencing. ***Nat. Protoc.*** (2023). https://doi.org/10.1038/s41596-022-00793-5