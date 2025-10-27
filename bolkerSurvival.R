cloglog <- make.link("cloglog")$linkfun

curve(cloglog(plogis(-5+2*x)), from = 0, to = 20, ylim = c(-2, 4))
curve(cloglog(plogis(5-2*x)), add=TRUE, col = 2)
curve(cloglog(plogis(5+x)), add=TRUE, col = 4)
curve(cloglog(plogis(5+log(x))), add=TRUE, col = 5)
curve(cloglog(plogis(0+log(x))), add=TRUE, col = 6)
