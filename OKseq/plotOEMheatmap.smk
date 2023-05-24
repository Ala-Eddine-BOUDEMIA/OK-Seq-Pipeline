configfile: "config/config.yaml"

rule plot_oem_heatmap:
    output:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_IZ.png", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_TZ.png", 
            dir=config["dir"], samples=config["samples"])
    input:
        IZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_IZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
        TZ = expand("{dir}/OKseqProfiles/{samples}/{samples}_OEM_TZ.matrix", 
            dir=config["dir"], samples=config["samples"]),
    run:
        for iIZ, oIZ, iTZ, oTZ in zip(input.IZ, output.IZ, input.TZ, output.TZ):
            sample = iIZ.split("/")[-1].split("_")[0]
            shell("plotHeatmap --matrixFile {iIZ} --outFileName {oIZ} \
            --whatToShow 'plot, heatmap and colorbar' \
            --samplesLabel '{sample} 1kb' '{sample} 10kb' '{sample} 20kb' '{sample} 50kb' '{sample} 100kb' '{sample} 250kb' '{sample} 500kb' '{sample} 1Mb'\
            --refPointLabel center --sortUsing region_length --sortRegions ascend"),
            shell("plotHeatmap --matrixFile {iTZ} --outFileName {oTZ} \
            --whatToShow 'plot, heatmap and colorbar' \
            --samplesLabel '{sample} 1kb' '{sample} 10kb' '{sample} 20kb' '{sample} 50kb' '{sample} 100kb' '{sample} 250kb' '{sample} 500kb' '{sample} 1Mb'\
            --refPointLabel center --sortUsing region_length --sortRegions ascend")