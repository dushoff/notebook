set.seed(0413)

n <- 10

## Series and two sub-series lagged with respect to each other
x <- rnorm(n)
y <- x[-1]
z <- x[-n]

## Plain correlation treats the first set and second set as separate series
cor.test(y, z)
print(sum((y-mean(y))*(z-mean(z)))/((n-2)*sd(y)*sd(z)))

## auto-correlation recognizes them as the same series
## So we use the grand mean and variance (and have more degrees of freedom)
print(acf(x))
print(sum((y-mean(x))*(z-mean(x)))/((n-1)*sd(x)*sd(x)))
