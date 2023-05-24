configfile: "config/config.yaml"

rule Average_RFD_profile:
    output:
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD.matrix", 
            dir=config["dir"], samples=config["samples"])
    input:
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bw", 
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"])
    params:
        codingGenes = "Reference/hg19/Coding_Genes/coding_genes.hg19.bed",
        brsl = 10000,
        arsl = 10000,
        rbl = 20000,
        bs = config["bin_size"]
    run:
        for i, o in zip(input, output):
            shell("computeMatrix scale-regions \
                --numberOfProcessors max \
                --regionsFileName {params.codingGenes} \
                --beforeRegionStartLength {params.brsl} \
                --afterRegionStartLength {params.arsl} \
                --regionBodyLength {params.rbl} --binSize {params.bs} \
                --scoreFileName {i} --outFileName {o} \
                --missingDataAsZero --skipZeros")