den <- function(f){ return (f[["den"]])}
num <- function(f){ return (f[["num"]])}

sums <- function(target, numVals, minDen=1){
	## print(c(target, numVals, minDen))
	if (numVals==1){
		if ((den(target) < minDen) || (num(target)>1))
			return(NULL)
		return(as.vector(den(target)))
	}
	minDen <- pmax(minDen 
		, 1+floor(den(target)/num(target))
	)
	maxDen <- floor(2*den(target)/num(target))
	if (minDen>maxDen) return(NULL)
	l <- list()
	lc <- 0
	for (d in minDen:maxDen){
		new <- sub(target, c(num=1, den=d))
		for (v in sums(new, numVals-1, minDen=d+1)){
			lc <- lc+1
			l[[lc]] <- c(d, v)
		}
	}
	if (length(l) == 0) return(NULL)
	return(l)
}

sub <- function(x, y){
	share <- gcd(den(x), den(y))
	return(c(
		num = (den(y)*num(x) - den(x)*num(y))/share
		, den = den(y)*den(x)/share
	))
}

gcd <- function(x, y){
	if (x==0) return(y)
	return(gcd(y%%x, x))
}

length(sums(c(num=1, den=1), 1))
length(sums(c(num=1, den=1), 2))
length(sums(c(num=1, den=1), 3))
length(sums(c(num=1, den=1), 4))
length(sums(c(num=1, den=1), 5))
length(sums(c(num=1, den=1), 6))