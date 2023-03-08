library(purrr)

library(shellpipes)

numSims <- 1e4
tRange <- seq(6, 1)

points <- 8
set.seed(7083)

dat <- list()

for (df in tRange){
	tag <- paste0("t_", df)
	dat[[tag]] <- list(
		mean = 0
		, sims=map(1:numSims, ~rt(points, df=df))
	)
}

rdsSave(dat)
