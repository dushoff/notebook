library(dplyr)
isSumAtom <- function(x, pl){
	ff <- factor(x, pl)
	good <- (ff
		|> filter (p%%4 == 1)
		|> summarize(g = sum(a))
		|> pull(g)
	)
	bad <- (ff
		|> filter (p%%4 == 3 & a%%2 == 1)
	)
	return(good > 0 & nrow(bad) == 0)
}

isSum <- Vectorize(isSumAtom, "x")

plist <- function(n){
	np <- logical(n)
	np[[1]] <- TRUE
	for (i in 2:floor(sqrt(n))){
		if(!np[[i]]) np[seq(2*i, n, by=i)] <- TRUE
	}
	return((1:n)[!np])
}

factor <- function(n, pl){
	a = numeric(length(pl))
	i <- 0
	while (n>1){
		i <- i+1
		while (n %% pl[[i]] == 0){
			n = n/pl[[i]]
			a[[i]] = a[[i]]+1
		}
	}
	ff <- data.frame(
		p = pl, a = a
	)
	return(ff |> filter(a>0))
}

