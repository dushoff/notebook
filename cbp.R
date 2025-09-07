
cbp <- function(probs, counts, λ){
	newprobs <- probs*exp(λ*counts)
	return(newprobs/sum(newprobs))
}

cbp(1:4, 0:3, -1)
cbp(1:4, 0:3, 0)
cbp(1:4, 0:3, 1)


######################################################################
## This was the original idea, but I think the direct one (above) is simpler and fine

## You should probably make this:
#### Check that initial probs are normalized (or just normalize them)
#### operate only on non-zero probs
#### just return the original probs if there is only one non-zero prob
cbpodds <- function(probs, counts, λ){
	probs <- probs/sum(probs)
	odds <- probs/(1-probs)
	newodds <- odds*exp(λ*counts)
	newprobs <- newodds/(1+newodds)
	return(newprobs/sum(newprobs))
}

cbpodds(1:4, 0:3, -1)
cbpodds(1:4, 0:3, 0)
cbpodds(1:4, 0:3, 1)
