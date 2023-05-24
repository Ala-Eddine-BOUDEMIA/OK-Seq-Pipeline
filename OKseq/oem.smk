configfile: "config/config.yaml"

rule OEM:
    output:
        expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_{binlist}kb.wig", 
            dir=config["dir"], samples=config["samples"], binlist=config["binlist"])
    input:
        bamInF = expand("{dir}/OKseqHMM/{samples}/{samples}_fwd.bam", 
            dir=config["dir"], samples=config["samples"]),
        bamInR = expand("{dir}/OKseqHMM/{samples}/{samples}_rev.bam",
            dir=config["dir"], samples=config["samples"])
    params:
        oem_dir = expand("{dir}/OKseqOEM/{samples}/", 
            dir=config["dir"], samples=config["samples"]),
        fileOut = directory(expand("{dir}/OKseqOEM/{samples}/{samples}", 
            dir=config["dir"], samples=config["samples"])),
        chrsizes = "Reference/hg19/Chr_Sizes/hg19.chrom.sizes",
        binSize = config["bin_size"]
    run:
        bl = ",".join(config["binlist"])
        for bif, bir, fo, oem_d in zip(input.bamInF, input.bamInR, params.fileOut, params.oem_dir):
            shell("mkdir -p {oem_d}"),
            shell("Rscript --vanilla OKseq/OKseqOEM.R -bIf {bif} -bIr {bir} -c {params.chrsizes} -f {fo} -bs {params.binSize} -bl {bl}")