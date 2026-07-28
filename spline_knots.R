library(splines)
## source("makestuff/makeRfuns.R")
## makeGraphics()

## 爸 <- 3
## print(爸^2)
## ☺ <- 7

## To save as .rds
## rdsSave(x)
x <- 1:30
y <- rnorm(30)
dd <- data.frame(x,y)
m1 <- lm(y~ns(x,4))
m2 <- lm(y~bs(x,4))
plot(x,predict(m1))
lines(x,predict(m2))
points(x,y,col=2,pch=3)
points(x,y,col=2,pch=3,cex=2)
points(x,y,col=2,pch=16,cex=2)

attr(terms(m1),"predvars")
attr(terms(m2),"predvars")

kvec <- seq(0,30,by=4)
m3 <- lm(y~bs(x,knots=kvec))
m4 <- lm(y~ns(x,knots=kvec))
