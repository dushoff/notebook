library(shellpipes)

loadEnvironments()
xtest <- function(x, p, eps=NULL){
	y <- powTrans(1:10, p, eps=eps)
	return(data.frame(
		x=x, y = y, inv= invTrans(y, p, eps=eps)
	))
}

ptest <- function(x, p, eps=NULL){
	pfun <- Vectorize(powTrans, "p")
	pw <- pfun(x=x, p=p, eps=eps)
	return(data.frame(
		p=p, pw=pw, diff=(pw-log(x))/p
	))
}

xtest(1:10, 1e-5, eps=1e-3)
xtest(1:10, 1e-5, eps=1e-6)
xtest(1:10, -1e-5, eps=1e-3)
xtest(1:10, -1e-5, eps=1e-6)

v <- exp(-12:0)
x <- c(rev(-v), v)
ptest(2, x)

powMean(1:10, p=10)
powMean(1:10, p=1)
powMean(1:10, p=1e-5)
powMean(1:10, p=0)
powMean(1:10, p=-1e-5)
powMean(1:10, p=-1)
powMean(1:10, p=-10)

v <- c(1, 2, 4)
powMean(v, p=-1)
powMean(v, p=0)
powMean(v, p=200)

