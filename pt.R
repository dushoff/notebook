set.seed(714)
ptgamma <- function(samp=30, shape=1){
	x <- rgamma(samp, shape=shape) - shape
	return(t.test(x)$p.value)
}

## Good behaviour with high shape
v <- replicate(10000, ptgamma(shape=100))
mean(v < 0.025)
mean(v > 0.975)

## Bad behaviour with exponential
v <- replicate(10000, ptgamma(shape=1))
mean(v < 0.025)
mean(v > 0.975)

## Larger sample size makes things better
v <- replicate(10000, ptgamma(samp=100, shape=1))
mean(v < 0.025)
mean(v > 0.975)
