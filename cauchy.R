library(purrr)

library(shellpipes)

numSims <- 1e4

points <- 8
set.seed(7084)

dat <- list(
	Cauchy = list(
		mean = 0
		, sims=map(1:numSims, ~rcauchy(points))
	)
)

rdsSave(dat)
