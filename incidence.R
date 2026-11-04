library(ggplot2); theme_set(theme_bw())

powFun <- function(n, theta){
	return(n^(1-theta))
}

satFun <- function(n, theta){
	return(n/(1-theta+n*theta))
}

## Human-friendly formula: f = (1-(1-theta)^n)/theta
## expm1(x) is exp(x)-1 and log1p(x) is log(1+x), so the code below is the same
## thing, written to stay accurate when theta is small
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

print(incPlot("Power", powFun))
print(incPlot("Saturating", satFun))
print(incPlot("Hazard", hazFun))
