#' [Plain code version](https://raw.githubusercontent.com/dushoff/notebook/gh-pages/breaks.R)

library(scales)

## log_breaks  is crazy!
log_breaks(n=3)(c(1, 1.2))
log_breaks(n=4)(c(1, 1.2))

## axisTicks is clunky, and gets carried away!
axisTicks(nint=4, log=TRUE, usr=log(c(1, 20)))

## The best I can do for now.
divmultbreaks <- function(v, n=6, nmin=3, anchor=TRUE){
	if (anchor) v <- unique(c(v, 1))
	v <- log(v)
	neg <- min(v)
	if (neg==0) return(axisTicks(nint=n, log=TRUE, usr=range(v)))
	pos <- max(v)
	if (pos==0) return(1/axisTicks(nint=n, log=TRUE, usr=-range(v)))

	flip <- -neg
	big <- pmax(pos, flip)
	small <- pmin(pos, flip)
	bigprop <- big/(pos + flip)
	bigticks <- ceiling(n*bigprop)

	main <- axisTicks(nint=bigticks, log=TRUE, usr=c(0, big))
	cut <- pmin(bigticks, 1+sum(main<small))
	if(cut<nmin)
		other <- axisTicks(nint=nmin, log=TRUE, usr=c(0, small))
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

