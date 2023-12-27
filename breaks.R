#' [Plain code version](https://raw.githubusercontent.com/dushoff/notebook/gh-pages/breaks.R)

library(scales)

## log_breaks  is crazy!
log_breaks(n=3)(c(1, 1.2))
log_breaks(n=4)(c(1, 1.2))

## axisTicks is clunky, and gets carried away!
axisTicks(nint=4, log=TRUE, usr=log(c(1, 20)))

splitDecades <- function(v){
	l <- length(v)
	w <- numeric(0)
	if (l>1) for (i in 1:(l-1)){
		w <- c(w, v[[i]])
		if (v[[i+1]]==10*v[[i]]) w <- c(w, 2*v[[i]], 5*v[[i]])
	}
	return(c(w, v[[l]]))
}

## limBreaks wraps axisTicks the way I use it, and drops things outside things that are on or at the boundary of the range
limBreaks <- function(v, n=5, split=FALSE){
	b <- axisTicks(nint=n, log=TRUE, usr=range(v))
	if(split) b <- splitDecades(b)
	upr <- min(b[log(b)>=max(v)])
	lwr <- max(b[log(b)<=min(v)])
	## print(c(lwr=lwr, upr=upr))
	return(b[(b>=lwr) & (b<=upr)])
}

divmultbreaks <- function(v, n=6, nmin=3, anchor=TRUE, split=FALSE){
	if (anchor) v <- unique(c(v, 1))
	v <- log(v)
	neg <- min(v)
	if (neg==0) return(limBreaks(v, n, split))
	pos <- max(v)
	if (pos==0) return(1/limBreaks(-v, n, split))

	flip <- -neg
	big <- pmax(pos, flip)
	small <- pmin(pos, flip)
	bigprop <- big/(pos + flip)
	bigticks <- ceiling(n*bigprop)

	main <- limBreaks(c(0, big), bigticks, split)
	cut <- pmin(bigticks, 1+sum(main<small))
	if(cut<nmin)
		other <- limBreaks(c(0, small), nmin, split)
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
divmultbreaks(y, split=TRUE)

exp(splitDecades(log(y)))

ros <- c(0.698, 2.044)
divmultbreaks(ros)
divmultbreaks(ros, n=7)
divmultbreaks(ros, nmin=5)
