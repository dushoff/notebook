set.seed(0400)
n <- 100
p <- 0.72
reps <- 5000

dtest <- function(x, n, p){
	p1 <- binom.test(x, n, p = p
		, alternative = c("less")
	)$p.value
	p2 <- binom.test(x, n, p = p
		, alternative = c("greater")
	)$p.value
	return((p1 + 1 - p2)/2)
}

checkplot <- function(plist, main="checkplot"
	, xlab="P", boxes=40, col="gray", lwd=1
){
	hist(plist
		, breaks=seq(0, 1, length.out=1+boxes)
		, main = main, xlab=xlab
		, probability=TRUE
		, col=col
	)
	abline(h=1, lty=2, lwd=lwd)
}

bvec <- replicate(reps, {
	x <- rbinom(1, size=n, prob=p)
	prop.test(x, n, p = p
		, alternative = c("less")
	)$p.value
})

dvec <- replicate(reps, {
	x <- rbinom(1, size=n, prob=p)
	dtest(x, n, p)
})

print(checkplot(bvec, "binom.test", boxes=10))
print(checkplot(dvec, "Tie corrected", boxes=10))
