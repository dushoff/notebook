reps = 1e5
set.seed(714)
pttgamma <- function(samp=30, shape=1){
	x <- rgamma(samp, shape=shape) - shape
	y <- rgamma(samp, shape=shape) - shape
	return(t.test(x,y)$p.value)
}

## Good behaviour with high shape
v <- replicate(reps, pttgamma(shape=100))
mean(v < 0.05)

## Bad behaviour with exponential?
v <- replicate(reps, pttgamma(shape=1))
mean(v < 0.05)

## Larger sample size makes things better
v <- replicate(reps, pttgamma(samp=100, shape=1))
mean(v < 0.05)
