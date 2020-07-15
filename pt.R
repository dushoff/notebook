ptgamma <- function(samp=30, shape=1){
	x <- rgamma(samp, shape=shape) - shape
	return(t.test(x)$p.value)
}

v <- replicate(10000, ptgamma(shape=100))

summary(v)
mean(v < 0.025)
mean(v > 0.975)

