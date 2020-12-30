library(rRlinks)
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw())

day <- 0.37
day <- 2.37
rmin <- -0.1/day
rmax <- 0.1/day
rsteps <- 100
Dmax <- 500/day

dr <- 0.057/day ## r_new-r_orig (PHE via Day)
Rscale <- 1.47 ## R_new/R_orig

g <- 6.6*day
kappal <- list(
	fixed=0
	, intermediate=0.5
	, exponential=1
)

week <- 7*day

######################################################################

Rmult <- function(r, g, kappa, Rscale){
	R_orig = genExp(r_orig*g, kappa)
	R_mult = R_orig*Rscale
	return(genLog(R_mult, kappa)/g)
}

######################################################################

r_orig <- seq(rmin, rmax, length.out=rsteps)

rf <- data.frame(r_orig)

for(n in names(kappal)){
	rf[[n]] <- Rmult(r, g, kappal[[n]], Rscale)
}

rf <- (rf
	%>% pivot_longer(!r_orig, names_to="distribution", values_to="r_new")
	%>% mutate(distribution=factor(distribution, levels=names(kappal)))
)

print(
	ggplot(rf)
	+ aes(x=r_orig*day, y=r_new*day, color=distribution)
	+ geom_line()
	+ xlab("r_orig (/day)")
	+ ylab("r_new (/day)")
	+ scale_color_manual(values = c("#E7B800", "#2E9FDF", "#FC4E07"))
)
