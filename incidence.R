library(ggplot2); theme_set(theme_bw())

library(shellpipes)
startGraphics()

## n = N/K
powFun <- function(n, theta){
	return(n^(1-theta))
}

satFun <- function(n, theta){
	return(n/(1-theta+n*theta))
}

## Human-friendly formula: f = (1-(1-theta)^n)/theta
## Rewritten with expm1 and log1p for accuracy
hazFun <- function(n, theta){
	stopifnot(length(theta)==1)
	if (theta==0) return(n)
	return(-expm1(n*log1p(-theta))/theta)
}

incPlot <- function(name, fun, theta=seq(0, 1, length.out=5)
	, n=seq(0.01, 1, by=0.01)
){
	d <- do.call(rbind, lapply(theta, function(th){
		data.frame(n=n, theta=th, f=fun(n, th))
	}))
	return(ggplot(d)
		+ aes(n, f, color=as.factor(theta))
		+ geom_line()
		## + scale_x_log10()
		+ labs(color="theta")
		+ ggtitle(name)
	)
}

## Same families, parameterized by h = f(1/2)
## h=0.5 is mass action (theta=0); h=1 is frequency dependence (theta=1)
powFunHalf <- function(n, h){
	return(powFun(n, 1+log2(h)))
}

satFunHalf <- function(n, h){
	return(satFun(n, 2-1/h))
}

hazFunHalf <- function(n, h){
	return(hazFun(n, 1-(1/h-1)^2))
}

halfIncPlot <- function(name, fun, h=seq(0.5, 1.0, by=0.1), ...){
	return(incPlot(name, fun, theta=h, ...) + labs(color="h"))
}

print(halfIncPlot("Power", powFunHalf))
print(halfIncPlot("Saturating", satFunHalf))
print(halfIncPlot("Hazard", hazFunHalf))
