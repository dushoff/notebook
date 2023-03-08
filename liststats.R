library(shellpipes)

dat <- rdsRead()

## This function is not currently used, but could be called when no mean is available in future
## It will be a source of instability for unstable distributions; better to use the theoretical mean in general
grandMean <- function(datList){
	mv <- sapply(datList, mean)
	return(mean(mv))
}

## Why do I fiddle p instead of doing the one-sided test?
## Because it's the efficient way to get CIs at the same time
multT <- function(datList, m=0){
	df <- as.data.frame(t(sapply(datList, function(d){
		t <- t.test(d-m)
		p <- (1-sign(t$statistic)*(1-t$p.value))/2
		w <- shapiro.test(d)$statistic
		return(c(p, t$est, t$conf.int, w))
	})))
	names(df) <- c("p", "est", "lower", "upper", "W")
	return(df)
}

## What is the tidy version of lapply?

stats <- list()

for (tag in names(dat)){
	stats[[tag]] <- multT(dat[[tag]]$sims, m=dat[[tag]]$mean)
}

saveEnvironment()
