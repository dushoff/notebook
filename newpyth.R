
library(shellpipes)

######################################################################

## Number theory: these functions are fun, but inefficient

gcd <- function(x,y) {
	r <- x%%y;
	return(ifelse(r, gcd(y, r), y))
}

prime <- Vectorize(function(x){
	return(
		sum(
			x%%2:(round(sqrt(x)))==0
		) == 0
	)
})

######################################################################

pythPoints <- function(picSize, pointSize, axes=FALSE){
	plot(NULL, NULL
		, xlim = c(-picSize^2, picSize^2)
		, ylim = c(-picSize^2, picSize^2)
		, xlab = ""
		, ylab = ""
		, axes = axes
	)

	xsign <- c(1, 1, -1, -1)
	ysign <- c(1, -1, 1, -1)

	for (i in 2:picSize){
		for (j in 1:(i-1)){
			r <- i^2 + j^2
			if (gcd(i, j)==1){
				kmax <- floor(picSize^2/r)
				if (kmax>0) for (k in 1:kmax){
					a <- 2*k*i*j
					b <- k*(i^2 - j^2)
					c <- k*r

					if(c<=picSize^2){
						color = ifelse(prime(c), "red", 
							ifelse(k==1, "blue", "black")
						)
						# print (data.frame(a, b, color))
						points(cex=pointSize*sqrt(c)/picSize
							, c(xsign*a, xsign*b)
							, c(ysign*b, ysign*a)
							, col=color
						)
					}
				}
			}
		}
	}
}

saveEnvironment()
