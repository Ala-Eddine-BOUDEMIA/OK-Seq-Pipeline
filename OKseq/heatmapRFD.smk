configfile: "config/config.yaml"

rule heatmap_RFD:
    output:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_TZ.matrix", 
            dir=config["dir"], samples=config["samples"])
    input:
        IZ = expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_IZ.bed", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_TZ.bed", 
            dir=config["dir"], samples=config["samples"]),
        bw = expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bw", 
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"])
    params:
        brsl = 100000,
        arsl = 100000,
        bs = config["bin_size"]
    run:
        for iIZ, oIZ, iTZ, oTZ, bigwig in zip(input.IZ, output.IZ, input.TZ, output.TZ, input.bw):
            shell("computeMatrix reference-point --numberOfProcessors max --regionsFileName {iIZ} \
                --beforeRegionStartLength {params.brsl} --afterRegionStartLength {params.arsl} \
                --binSize {params.bs} --scoreFileName {bigwig} --outFileName {oIZ} \
                --missingDataAsZero --skipZeros --referencePoint center"),
            shell("computeMatrix reference-point --numberOfProcessors max --regionsFileName {iTZ} \
                --beforeRegionStartLength {params.brsl} --afterRegionStartLength {params.arsl} \
                --binSize {params.bs} --scoreFileName {bigwig} --outFileName {oTZ} \
                --missingDataAsZero --skipZeros --referencePoint center")