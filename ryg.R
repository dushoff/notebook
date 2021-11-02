library(shellpipes)
startGraphics()

plot(NULL, NULL
	, axes=FALSE, xlab="", ylab=""
	, xlim=c(0,1), ylim=c(0,1)
)
points(
	x = (1:3)/4
	, y = rep(1/2, 3)
	, pch=20, cex=8
	, col = c(
		rgb(1.0, 0, 0)
		, rgb(0.8, 0.8, 0)
		, rgb(0.4, 1.0, 0.4)
	)
)
