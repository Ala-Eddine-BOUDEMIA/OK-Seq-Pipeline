configfile: "config/config.yaml"

rule plot_heatmap:
    output:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_IZ.png", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_TZ.png", 
            dir=config["dir"], samples=config["samples"])
    input:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_RFD_TZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
    run:
        for iIZ, oIZ, iTZ, oTZ in zip(input.IZ, output.IZ, input.TZ, output.TZ):
            sample = iIZ.split("/")[-1].split("_")[0]
            shell("plotHeatmap --matrixFile {iIZ} --outFileName {oIZ} \
            --whatToShow 'plot, heatmap and colorbar' --samplesLabel {sample} \
            --refPointLabel center --sortUsing region_length --sortRegions ascend"),
            shell("plotHeatmap --matrixFile {iTZ} --outFileName {oTZ} \
            --whatToShow 'plot, heatmap and colorbar' --samplesLabel {sample} \
            --refPointLabel center --sortUsing region_length --sortRegions ascend")