library(dplyr)
library(ggplot2); theme_set(theme_bw())

library(shellpipes)
startGraphics()

set.seed(211)

## Pick random order statistics
rorder <- function(n, s, o, rname, ran=NULL, ...){
	one <- function(s, o, ran, ...){
		v <- do.call(ran, list(n=s, ...))
		return(sort(v)[[o]])
	}
	if(is.null(ran)) {ran <- get(paste0("r", rname))}
	return(sapply(1:n, function(i) one(s, o, ran, ...)))
}

## Order statistic density function
dorder <- function(x, s, o, rname, dfun=NULL, pfun=NULL, ...){
	if(is.null(dfun)) {dfun <- get(paste0("d", rname))}
	if(is.null(pfun)) {pfun <- get(paste0("p", rname))}
	q <- do.call(pfun, list(q=x, ...))
	g <- do.call(dfun, list(x=x, ...))
	bet = dbeta(q, o, 1+s-o)
	return(g*bet)
}

testPlot <- function(s, o, rname="lnorm", n=1e4, bins=40, ...){
	k <- tibble(NULL
		, x=rorder(n, s, o, rname, ...)
		, den = dorder(x, s, o, rname, ...)
	)

	return(ggplot(k)
		+ aes(x, after_stat(density))
		+ geom_histogram(binwidth=diff(range(k$x))/bins, boundary=0)
		+ geom_line(aes(y=den))
	)
}

print(testPlot(4, 4, n=4e4, sdlog=0.7, bins=100))
print(testPlot(7, 4, n=4e4, rname="gamma", shape=2))
