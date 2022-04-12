
## A perfectly reasonable posfun
## takes 0 to ε
## perfectly smooth
## converges to x for x≫ε
x <- seq(0, 10, by=0.002)
ε <- 1

y <- x + ε*exp(-x/ε)

plot(x, y
	, xlim=c(0, 2)
	, ylim=c(0, 2)
)
lines(x, x)

plot(x, y
	, xlim=c(0, 10)
	, ylim=c(0, 10)
)
lines(x, x)
