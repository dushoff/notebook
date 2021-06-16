library(rRlinks) ## From https://github.com/mac-theobio/rRlinks
library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw(base_size=16))
library(shellpipes); startGraphics()

## day is a dummy; we change the value to make sure we haven't screwed up units
day <- 2.37
day <- 0.37
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
Rmult <- function(r, g, kappa, Rscale, gmult=1){
	R_orig = genExp(r_orig*g, kappa)
	R_mult = R_orig*Rscale
	return(genLog(R_mult, kappa)/(g*gmult))
}

######################################################################

r_orig <- seq(rmin, rmax, length.out=rsteps)

yl <- c(0, 0.12)

## Loop over different assumptions about gmult
for(gmult in c(1, 1/1.25, 1.25)){
	rf <- data.frame(r_orig)
	## Calculate r_new for a range of r_old and a few distribution assumptions
	for(n in names(kappal)){
		rf[[n]] <- Rmult(r, g, kappal[[n]], Rscale, gmult)
	}

	rf <- (rf
		%>% pivot_longer(!r_orig, names_to="distribution", values_to="r_new")
		%>% mutate(distribution=factor(distribution, levels=names(kappal)))
		%>% mutate(δr = r_new-r_orig)
	)

	old <- (
		ggplot(rf)
		+ ggtitle(expression(paste(beta[new]/beta[orig], "= 1.47")))
		+ aes(x=r_orig*day, y=r_new*day, color=distribution)
		+ geom_line()
		+ xlab("r_orig (/day)")
		+ ylab("r_new (/day)")
		+ scale_color_manual(values = c("#E7B800", "#2E9FDF", "#FC4E07"))
		+ geom_abline(slope=1, intercept=0, lty=3)
		+ theme(legend.position="top")
	)

	print(
		ggplot(rf)
		+ ggtitle(expression(paste(beta[new]/beta[orig], "= 1.47")))
		+ aes(x=r_orig*day, y=δr*day, color=distribution)
		+ geom_line()
		+ xlab(expression(paste(r[wt], "(/day)")))
		+ ylab(expression(paste(delta*r, "(/day)")))
		+ scale_color_manual(values = c("#E7B800", "#2E9FDF", "#FC4E07"))
		+ ylim(yl)
		+ theme(legend.position="bottom")
	)
}
