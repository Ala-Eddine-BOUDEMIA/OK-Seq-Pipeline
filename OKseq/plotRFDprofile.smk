configfile: "config/config.yaml"

rule plot_RFD_profile:
    output:
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_averageProfile.png", 
            dir=config["dir"], samples=config["samples"])
    input:
        expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD.matrix", 
            dir=config["dir"], samples=config["samples"])
    params:
        codingGenes = "Reference/hg19/Coding_Genes/coding_genes_hg19_NOV_0kb.bed",
        brsl = 10000,
        arsl = 10000,
        rbl = 20000,
        bs = config["bin_size"]
    run:
        for i, o in zip(input, output):
            sample = i.split("/")[-1].split(".")[0]
            shell("plotProfile --matrixFile {i} --outFileName {o}  \
                --averageType mean --startLabel TSS --endLabel TTS \
                --samplesLabel {sample} --plotType se \
                --plotHeight 20 --plotWidth 30")