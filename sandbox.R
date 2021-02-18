
x <- seq(2, 10, by=0.04)
x <- exp(seq(-3, 3, by=0.4))
y = x/log10(x)

## data.frame(x[-length(x)], diff(x))
log(1+diff(x)/x[-length(x)])
diff(log(x))

plot(x, y, type="l")
