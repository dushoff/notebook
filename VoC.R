
library(rRlinks)
library(dplyr)
library(tidyr)
library(ggplot2)

day <- 2.37
day <- 0.37
rmin <- -0.1/day
rmax <- 0.1/day
rsteps <- 100
Dmax <- 500/day

dr <- 0.057/day ## r_new-r_orig (PHE via Day)
Rscale <- 1.47 ## R_new/R_orig

g <- 6.6*day
kappa <- 0

week <- 7*day

######################################################################

r_orig <- seq(rmin, rmax, length.out=rsteps)

calcf <- (data.frame(r_orig)
	%>% mutate(
		r_offset = r_orig + dr
		, R_orig = genExp(r_orig*g, kappa)
		, R_mult = R_orig*Rscale
		, r_mult = genLog(R_mult, kappa)/g
	)
)

rf <- (calcf
	%>% select(contains("r_", ignore.case=FALSE))
	%>% pivot_longer(!r_orig, names_to="method", values_to="r_new")
	%>% mutate(r_orig=r_orig*day, r_new=r_new*day
		, method=sub("r_", "", method)
	)
)

print(rf)

Df <- (rf
	%>% transmute(
		D_orig = log(2)/r_orig
		, D_new = log(2)/r_new
		, method=method
	)
	%>% filter(D_orig < Dmax/day)
)

print(
	ggplot(rf)
	+ aes(x=r_orig, y=r_new, color=method)
	+ geom_point()
	+ geom_line()
)

silent <- (
	ggplot(Df)
	+ aes(x=D_orig, y=D_new, color=method)
	+ geom_point()
	+ geom_line()
)
