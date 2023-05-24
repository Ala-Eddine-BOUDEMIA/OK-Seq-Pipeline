configfile: "config/config.yaml"

include: "OKseq/averageRFDprofile.smk"
include: "OKseq/bedgraph2bw.smk"
include: "OKseq/heatmapOEM.smk"
include: "OKseq/heatmapRFD.smk"
include: "OKseq/hmm.smk"
include: "OKseq/oem.smk"
include: "OKseq/plotHeatmapRFD.smk"
include: "OKseq/plotOEMheatmap.smk"
include: "OKseq/plotRFDprofile.smk"
include: "OKseq/wig2bigwig.smk"

rule all:
    input:
        expand("{dir}/BAM/{samples}.bam", 
            dir=config["dir"], samples=config["samples"]),
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
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"]),
        expand("{dir}/OKseqHMM/{samples}/{samples}_RFD_cutoff{thresh}_bs1kb.bw", 
            dir=config["dir"], samples=config["samples"], thresh=config["hmm_thresh"]),
        expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_{binlist}kb.wig", 
            dir=config["dir"], samples=config["samples"], binlist=config["binlist"]),
        expand("{dir}/OKseqOEM/{samples}/{samples}_OEM_{binlist}kb.bw", 
            dir=config["dir"], samples=config["samples"], binlist=config["binlist"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD.matrix", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_averageProfile.png", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_TZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_IZ.png", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_TZ.png", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_TZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_IZ.png", 
            dir=config["dir"], samples=config["samples"]),
        expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_TZ.png", 
            dir=config["dir"], samples=config["samples"])