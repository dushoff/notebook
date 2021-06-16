
n <- 100
bx <- 1
by <- 1
b0 <- 3

x <- rnorm(n)
y <- rnorm(n)

lin <- b0 + bx*x + by*y

prob <- plogis(lin)

