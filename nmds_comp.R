#load libraries, data
library(vegan)
library(MASS)
library(ggplot2)
theme_set(theme_bw())

# A distance matrix 
data(dune)
mdis<-vegdist(dune, method="horn")

# Compare mds results with and without transformation
# Use procrustes to avoid scale and rotation problems
comp <- function(dis, mdsfun, transfun, label=""){
	osc <- scores(mdsfun(dis))[, 1:2]
	tsc_raw <- scores(mdsfun(transfun(dis)))[, 1:2]
	tsc <- procrustes(osc, tsc_raw)$Yrot

	osc <- data.frame(osc)
	tsc <- data.frame(tsc)

	osc[["distance"]] = "orig"
	tsc[["distance"]] = "trans"

	names(osc)[1:2] <- c("x", "y")
	names(tsc)[1:2] <- c("x", "y")

	sc <- rbind(osc, tsc)
	print(ggplot(sc, aes(x=x, y=y, color=distance))
		+ labs(title=label)
		+ scale_color_manual(values=c("red", "blue"))
		+ geom_point(alpha=0.6)
	)
	return(sc)
}

comp(mdis, isoMDS, sqrt, "MASS/iso")
comp(mdis, metaMDS, sqrt, "vegan/mono")

## Wrapper so we can try vegan/iso
## This gives an error with engine = isoMDS, but not with monoMDS, which is weird and I'm dropping it.
metaISO <- function (dis){
	return(metaMDS(dis, engine="isoMDS"))
}
# comp(mdis, metaISO, sqrt, "vegan/iso")
