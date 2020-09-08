reps <- 1e6
n <- 25
p <- 0.7
prob <- c(p*p, 2*p*(1-p), (1-p)*(1-p))
pred <- n*prob

expt <- rmultinom(reps, n, prob)

chiwrong <- apply(expt, 2, function(v){
	return(sum((v-pred)^2/pred))
})

chi <- apply(expt, 2, function(v){
	p <- (v[[1]]+v[[2]]/2)/sum(v)
	prob <- c(p*p, 2*p*(1-p), (1-p)*(1-p))
	pred <- sum(v)*prob
	return(sum((v-pred)^2/pred))
})

print(quantile(chi, prob=c(0.5, 0.95)))

