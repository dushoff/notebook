plot(NULL, NULL
	, axes=FALSE, xlab="", ylab=""
	, xlim=c(0,1), ylim=c(0,1)
)

points(
	x = rep((1:2)/3, 2)
	, y = rep(c(1, 3)/4, each=2)
	, pch=20, cex=8
	, col = c(
		rgb(1, 0, 0)
		, rgb(0.2, 1, 0.2)
		# , rgb(1, 1, 0)
		, rgb(1, 0.4, 0.4)
		, rgb(0, 0.8, 0)
		# , rgb(1, 1, 0)
	)
)

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

