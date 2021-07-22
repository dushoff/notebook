issquare <- function(x){
	s <- floor(sqrt(x+1e-4))
	return(s*s == x)
}

divsum <- function(x){
	l <- 1:(x-1)
	r <- x%%l
	return(sum(l[r==0]))

}

for (i in 1:120){
	print(c(i, divsum(i)))
}
