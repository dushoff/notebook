#' [Plain code version](https://raw.githubusercontent.com/dushoff/notebook/gh-pages/breaks.R)

library(scales)

## log_breaks  is crazy!
log_breaks(n=3)(c(1, 1.2))
log_breaks(n=4)(c(1, 1.2))

## axisTicks is clunky, and gets carried away!
axisTicks(nint=4, log=TRUE, usr=log(c(1, 20)))

## The best I can do for now.

limBreaks <- function(v, n=5){
	b <- axisTicks(nint=n, log=TRUE, usr=range(v))
	upr <- min(b[log(b)>=max(v)])
	lwr <- max(b[log(b)<=min(v)])
	print(c(lwr=lwr, upr=upr))
	return(b[(b>=lwr) & (b<=upr)])
}

divmultbreaks <- function(v, n=6, nmin=3, anchor=TRUE){
	if (anchor) v <- unique(c(v, 1))
	v <- log(v)
	neg <- min(v)
	if (neg==0) return(limBreaks(v, n))
	pos <- max(v)
	if (pos==0) return(1/limBreaks(-v, n))

	flip <- -neg
	big <- pmax(pos, flip)
	small <- pmin(pos, flip)
	bigprop <- big/(pos + flip)
	bigticks <- ceiling(n*bigprop)

	main <- limBreaks(c(0, big), bigticks)
	cut <- pmin(bigticks, 1+sum(main<small))
	if(cut<nmin)
		other <- limBreaks(c(0, small), nmin)
	else
		other <- main[1:cut]

	breaks <- c(main, 1/other)
	if (flip > pos) breaks <- 1/breaks
	return(sort(unique(breaks)))
}

divmultbreaks(c(11))
divmultbreaks(c(0.04))

divmultbreaks(c(0.04, 11))
divmultbreaks(c(0.02, 2))
divmultbreaks(c(0.8, 20))

y <- (exp(seq(-2,5,0.2)))
range(y)
divmultbreaks(y)

