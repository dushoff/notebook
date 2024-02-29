
set.seed(26688)

reps <- 999
sdl <- 0.5

n <- 10
a <- 0.5
b <- 3.5
eps <- 0.5

x <- rnorm(n)
m <- a*x + b
sdm <- log(m) - sdl^2/2
y <- rlnorm(n, sdm, sdl)

plot(x, y)

m <- lm(y~x)

confint(m)

slope <- function(x, y){
	return(
		coef(lm(y~x))[["x"]]
	)
}

ranslope <- function(x, y){
	return(slope(x, sample(y)))
}

est <- slope(x, y)
null <- replicate(reps, ranslope(x, y))
samps <- c(0, est-null)
quantile(samps, probs=c(0.025, 0.975))
