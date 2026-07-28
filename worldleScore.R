n <- 1000 
g <- c(0, 39, 355, 410, 146, 40)
l <- n-sum(g)
print(c(score=(sum(1:6*g) + 24*l)/n))
