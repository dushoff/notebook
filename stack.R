
bags <- function(penalty){
	return(floor(penalty/(1:penalty)))
}

maxCoins <- function(penalty, target=0){
	m <- sum(bags(penalty))
	return(m-target)
}

minPen <- function(coins){
	return(uniroot(maxCoins, target=coins, lower=1, upper=coins))
}

print(minPen(1000))
print(maxCoins(186))
