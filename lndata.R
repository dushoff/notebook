library(purrr)

library(shellpipes)

numSims <- 1e4
sdlogRange <- seq(0.01, 0.51, length.out=11)

points <- 20
set.seed(7084)

dat <- list()

for (sdlog in sdlogRange){
	tag <- paste0("sdlog_", sdlog)
	dat[[tag]] <- list(
		mean = exp(sdlog^2/2)
		, sims=map(1:numSims, ~rlnorm(points, sdlog=sdlog))
	)
}

rdsSave(dat)
