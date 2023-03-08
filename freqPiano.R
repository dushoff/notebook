library(ggplot2); theme_set(theme_bw())

library(shellpipes)
loadEnvironments()

set.seed(1256)

## Return a one-sided P value from a t-test
ttP <- function(dat, mean){
	return(t.test(dat, mu=mean, alternative="less")$p.value)
}

## Do a null simulation
simP <- function(n, mean, sd){
	return(ttP(
		rnorm(n, mean, sd), mean
	))
}

## Do all the simulations

nreps <- 1e5
mean <- 0
sd <- 2
n <- 10

Pvec <- replicate(nreps, simP(n, mean, sd))

print(pianoPlot(Pvec))
