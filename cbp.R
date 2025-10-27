
cbp <- function(probs, counts, λ){
	newprobs <- probs*exp(λ*counts)
	return(newprobs/sum(newprobs))
}

cbp(1:4, 0:3, -1)
cbp(1:4, 0:3, 0)
cbp(1:4, 0:3, 1)
