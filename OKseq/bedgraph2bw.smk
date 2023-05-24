configfile: "config/config.yaml"

rule bedgraph2bw:
    output:
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bw", 
            dir=config["dir"], samples=config["samples"], thresh=config['hmm_thresh'])
    input:
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bedgraph", 
            dir=config["dir"], samples=config["samples"], thresh=config['hmm_thresh'])
    params:
        chrsizes = "Reference/hg19/Chr_Sizes/hg19.chrom.sizes"
    run:
        for i, o in zip(input, output):
            shell("OKseq/bedGraphToBigWig {i} {params.chrsizes} {o}")