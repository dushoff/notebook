

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2); theme_set(theme_bw())

library(shellpipes)
startGraphics()
```

```
## Error in makeArgs(): Define callArgs to use makeR files; see .args file?
```

```r
steps <- 100
bins <- 40
n <- 4e4
p <- 10
o <- 2
set.seed(211)

## A function to pick a random order statistic
os <- function(p, o, ran){
	return(sort(ran(p))[[o]])
}
ros <- function(n, p, o, ran=runif){
	return(sapply(1:n, function(i) os(p, o, ran)))
}

## An example with uniform
## The order-statistic follows the binomial logic outlined at lunch, so it
## has a beta distribution (conjugate to the binomial)
kuni <- tibble(NULL
	, x=ros(n, p, o)
	, bet = dbeta(x, o, 1+p-o)
)

uplot <- (ggplot(kuni)
	+ aes(x, after_stat(density))
	+ geom_histogram(binwidth=1/bins, boundary=0)
	+ geom_line(aes(y=bet))
)

kbet <- tibble(NULL
	, x=ros(n, p, o, rexp)
	, U = 1-exp(-x)
	, bet = dbeta(U, o, 1+p-o)*(1-U)
)

uplot %>% teeGG(ext="png", desc="uniform")
```

```
## Error in makeArgs(): Define callArgs to use makeR files; see .args file?
```

```r
(uplot %+% kbet) %>% teeGG(ext="png", desc="exp")
```

```
## Error in makeArgs(): Define callArgs to use makeR files; see .args file?
```

