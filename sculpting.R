n <- 1e5

a <- 1/2
b <- 1/2

x <- rbeta(n, a, b)
x <- rlnorm(n, meanlog=-1)

fkap <- Vectorize(function(x, lam){
	wt <- exp(-lam*x)
	M0 <- sum(wt)
	M1 <- sum(wt*x)
	M2 <- sum(wt*x^2)
	return(M0*M2/(M1^2)-1)
}, "lam")

fkap(x, 0:20)
