library(ggplot2)

set.seed(444332)

reps <- 5e3
dmax <- 20

reps <- 5e2
dmax <- 4

euclid <- function(v1, v2){
	return(sqrt(mean((v1-v2)^2)))
}

lam <- function(vlist){
	D <- sapply (2:4, function(first){
		other <- vlist[-c(1, first)]
		return(euclid(vlist[[1]], vlist[[first]]) 
			+ euclid(other[[1]], other[[2]])
		)
	})
	return((max(D)-median(D))/min(D))
}

lsamp <- function(dim, rfun){
	vl <- list()
	for(i in 1:4){
		vl[[i]] <- rfun(dim)
	}
	return(lam(vl))
}

lsim <- function(dim, reps, rfun=rnorm){
	return(sapply(1:reps, function(r){
		return(lsamp(dim, rfun))
	}))
}

lcurve <- function(dmax, reps, rfun=rnorm){
	lc <- sapply(1:dmax, function(d){
		s <- lsim(d, reps, rfun)
		return(c(d=d, m = mean(s), σ=sd(s)))
	})
	lc <- as.data.frame(t(lc))
	return(lc)
}

ndat <- lcurve(dmax, reps)
cdat <- lcurve(dmax, reps, rcauchy)
