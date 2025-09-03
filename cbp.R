
## Just trying to clarify the concept

## You should probably make this:
#### Check that initial probs are normalized (or just normalize them)
#### operate only on non-zero probs
#### just return the original probs if there is only one non-zero prob
cbpodds <- function(probs, counts, λ){
	odds <- probs/(1-probs)
	newodds <- odds*exp(λ*counts)
	newprobs <- newodds/(1+newodds)
	return(newprobs/sum(newprobs))
}

## OR: Just do it directly (why do we need odds?)
## I think I like this one better now
## Also, doesn't require the fussing above

cbp <- function(probs, counts, λ){
	newprobs <- probs*exp(λ*counts)
	return(newprobs/sum(newprobs))
}

cbpodds((1:4)/10, 0:3, 1)
cbp(1:4, 0:3, -1)

