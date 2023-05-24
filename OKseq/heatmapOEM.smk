configfile: "config/config.yaml"

rule heatmap_OEM:
    output:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_TZ.matrix", 
            dir=config["dir"], samples=config["samples"])
    input:
        IZ = expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_IZ.bed",
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_TZ.bed",
            dir=config["dir"], samples=config["samples"]),
        bw1 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_1kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw10 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_10kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw20 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_20kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw50 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_50kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw100 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_100kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw250 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_250kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw500 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_500kb.bw",
            dir=config["dir"], samples=config["samples"]),
        bw1000 = expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_1000kb.bw",
            dir=config["dir"], samples=config["samples"]),
    params:
        brsl = 100000,
        arsl = 100000,
        bs = config["bin_size"]
    run:
        for iIZ, oIZ, iTZ, oTZ, bw1, bw2, bw3, bw4, bw5, bw6, bw7, bw8 in \
            zip(input.IZ, output.IZ, input.TZ, output.TZ,
                input.bw1, input.bw10, input.bw20, input.bw50,
                input.bw100, input.bw250, input.bw500, input.bw1000):
            shell("computeMatrix reference-point --numberOfProcessors max --regionsFileName {iIZ} \
                --beforeRegionStartLength {params.brsl} --afterRegionStartLength {params.arsl} \
                --binSize {params.bs} --scoreFileName {bw1} {bw2} {bw3} {bw4} {bw5} {bw6} {bw7} {bw8} \
                --outFileName {oIZ} --missingDataAsZero --skipZeros --referencePoint center"),
            shell("computeMatrix reference-point --numberOfProcessors max --regionsFileName {iTZ} \
                --beforeRegionStartLength {params.brsl} --afterRegionStartLength {params.arsl} \
                --binSize {params.bs} --scoreFileName {bw1} {bw2} {bw3} {bw4} {bw5} {bw6} {bw7} {bw8} \
                --outFileName {oTZ} --missingDataAsZero --skipZeros --referencePoint center")