
## Transform to and from a stable scale that is linearly related to x^p
## The idea is to smoothly allow first-order approximation when p is small
powTrans <- function(x, p, eps=1e-5, warn=10){
	if(is.null(eps)) eps<-1e-5
	if(abs(p) > eps){
		return((x^p - 1)/p)
	}
	ell <- log(x)
	if ((m<-max(abs(ell)))>warn)
		warning("big value (abslog ", m, ") in powTrans")
	return(ell+p*ell^2/2)
}

invTrans <- function(y, p, eps=1e-5){
	if(is.null(eps)) eps<-1e-5
	if(abs(p) > eps){
+ 		return((p*y + 1)^(1/p))
	}
	return(exp(y-p*y^2/2))
}

wmean <- function(x, wts=1){
	return(sum(wts*x)/sum(wts+0*x))
}

powMean <- function(x, p, wts=1, eps=NULL){
	pw <- powTrans(x, p, eps)
	pm <- wmean(pw, wts)
	return(invTrans(pm, p, eps))
}

