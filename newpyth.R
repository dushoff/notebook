max <- 50
psize <- 0.7

plot(NULL, NULL
	, xlim = c(-max^2, max^2)
	, ylim = c(-max^2, max^2)
	, xlab = ""
	, ylab = ""
	, axes = FALSE
)

xsign <- c(1, 1, -1, -1)
ysign <- c(1, -1, 1, -1)

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

for (i in 2:max){
	for (j in 0:(i-1)){
		a <- 2*i*j
		b <- i^2 - j^2
		c <- i^2 + j^2

		if(c<=max^2){
			color = ifelse(prime(c), "red", 
				ifelse(gcd(a, b)==1, "blue", "black")
			)
			# print (data.frame(a, b, color))
			points(cex=psize*sqrt(c)/max
				, c(xsign*a, xsign*b)
				, c(ysign*b, ysign*a)
				, col=color
			)
		}
	}
}
