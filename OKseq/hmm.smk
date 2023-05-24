configfile: "config/config.yaml"

rule HMM:
    output:
        expand("{dir}/OKseqHMM/{samples}/{samples}_fwd.bam", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_fwd.bam.bai", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_rev.bam", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_rev.bam.bai", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMM.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMproba.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_highFlatZone.bed", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_highFlatZone.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_LowFlatZone.bed", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_LowFlatZone.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_IZ.bed", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_IZ.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_TZ.bed", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_HMMsegments_TZ.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_log.txt", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb_sm_15kb.bedgraph", 
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bedgraph", 
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"])
    input:
        bamfiles = expand("{dir}/BAM/{samples}.bam", 
            dir=config["dir"], samples=config["samples"])
    params:
        hmm_dir = expand("{dir}/OKseqHMM/{samples}/", 
            dir=config["dir"], samples=config["samples"]),
        fileOut = directory(expand("{dir}/OKseqHMM/{samples}/{samples}", 
            dir=config["dir"], samples=config["samples"])),
        chrsizes = "Reference/hg19/Chr_Sizes/hg19.chrom.sizes",
        thresh = config["hmm_thresh"],
        winS = config["hmm_winS"],
        binSize = config["bin_size"]
    run:
        for bam, fo, hmm_d in zip(input.bamfiles, params.fileOut, params.hmm_dir):
            shell("mkdir -p {hmm_d}"),
            shell("Rscript --vanilla OKseq/OKseqHMM.R -b {bam} -c {params.chrsizes} -f {fo} -th {params.thresh} -w {params.winS} -bs {params.binSize}")