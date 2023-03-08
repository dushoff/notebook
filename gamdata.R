library(purrr)

library(shellpipes)

numSims <- 1e4
kRange <- seq(0.01, 0.51, length.out=11)

points <- 8
set.seed(7084)

dat <- list()

for (k in kRange){
	tag <- paste0("k_", k)
	dat[[tag]] <- list(
		mean = 1/k
		, sims=map(1:numSims, ~rgamma(points, shape=1/k))
	)
	print(tag)
	print(sapply(dat[[tag]], mean))
}

rdsSave(dat)
