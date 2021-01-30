library(rRlinks) ## This is a package from https://github.com/mac-theobio/rRlinks
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw())

## day is a dummy; we change the value to make sure we haven't screwed up units
day <- 0.37
day <- 2.37
week <- 7*day

## Assumptions
dr <- 0.057/day ## r_new-r_orig (PHE via Day) ## Not used
Rscale <- 1.47 ## R_new/R_orig (PHE)
g <- 6.6*day

rmin <- -0.1/day
rmax <- 0.1/day
rsteps <- 100

kappal <- list(
	fixed=0
	, intermediate=0.5
	, exponential=1
)

######################################################################

## Calculate a new r by multiplying R by the given scale
## i.e., transform, multiply, back-transform
Rmult <- function(r, g, kappa, Rscale){
	R_orig = genExp(r_orig*g, kappa)
	R_mult = R_orig*Rscale
	return(genLog(R_mult, kappa)/g)
}

######################################################################

r_orig <- seq(rmin, rmax, length.out=rsteps)
rf <- data.frame(r_orig)

## Calculate r_new for a range of r_old and a few distribution assumptions
for(n in names(kappal)){
	rf[[n]] <- Rmult(r, g, kappal[[n]], Rscale)
}

rf <- (rf
	%>% pivot_longer(!r_orig, names_to="distribution", values_to="r_new")
	%>% mutate(distribution=factor(distribution, levels=names(kappal)))
	%>% mutate(δr = r_new-r_orig)
)

print(
	ggplot(rf)
	+ aes(x=r_orig*day, y=r_new*day, color=distribution)
	+ geom_line()
	+ xlab("r_orig (/day)")
	+ ylab("r_new (/day)")
	+ scale_color_manual(values = c("#E7B800", "#2E9FDF", "#FC4E07"))
)

print(
	ggplot(rf)
	+ aes(x=r_orig*day, y=δr*day, color=distribution)
	+ geom_line()
	+ xlab("r_orig (/day)")
	+ ylab("δr (/day)")
	+ scale_color_manual(values = c("#E7B800", "#2E9FDF", "#FC4E07"))
)
