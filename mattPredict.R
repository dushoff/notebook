
n <- 20
beta <- 2
eps <- 1

x <- 1:n
yest <- beta*x
y <- rnorm(yest, eps)

m <- lm(
