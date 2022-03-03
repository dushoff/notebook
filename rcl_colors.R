library(dplyr)

library(shellpipes)
startGraphics()

n <- 3
tau <- 2*pi
taudeg <- 360
theta0 <- tau/6

## Non-linear transformation seems good, but there's still an unwanted axis of green-red symmetry.
phifun <- function(theta, alpha=0.9, target=0){
	return(theta-alpha*sin(2*(theta))/2-target)
}

thefun <- Vectorize(function(theta, alpha=0.9, theta0=tau/6){
	return(uniroot(phifun, target=theta, lower=0, upper=tau)$root)
}, vectorize.args="theta")

## Go how far around the circle
wrap <- 0.5
prop <- (2*(1:n)-1)/(2*n)
phi <- wrap*prop*tau
the <- thefun(phi)

## When I do half wrap, the thetas look worse to me!
## They seemed better in the full wrap?
pie(rep(1, n), col = hcl(h = (theta0+phi)*taudeg/tau, c=60, l=50))
pie(rep(1, n), col = hcl(h = (theta0+the)*taudeg/tau, c=60, l=50))
pie(rep(1, n), col = hcl(h = (theta0-phi)*taudeg/tau))
pie(rep(1, n), col = hcl(h = (theta0-the)*taudeg/tau))

