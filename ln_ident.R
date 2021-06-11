n <- 1e6
seed <- 21

set.seed(seed)

r <- rlnorm(n)

h <- 1/mean(1/r)
g <- exp(mean(log(r)))
a <- mean(r)

print(c(h=h, g=g, a=a, mid = sqrt(h*a)))

h <- 1/mean(r)
g <- exp(-mean(log(r)))
a <- mean(1/r)

print(c(h=h, g=g, a=a, mid = sqrt(h*a)))
