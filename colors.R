## A red-green comparison

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

## A red-green ramp
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

## Brighter
plot(NULL, NULL
	, axes=FALSE, xlab="", ylab=""
	, xlim=c(0,1), ylim=c(0,1)
)
points(
	x = (1:3)/4
	, y = rep(1/2, 3)
	, pch=20, cex=8
	, col = c(
		rgb(1.0, 0.5, 0.5)
		, rgb(0.9, 0.9, 0.5)
		, rgb(0.7, 1.0, 0.7)
	)
)


## A more neutral color ramp (for Michelle)
## This worked way less well than I was expecting

plot(NULL, NULL
	, axes=FALSE, xlab="", ylab=""
	, xlim=c(0,1), ylim=c(0,1)
)

points(
	x = (1:4)/5
	, y = rep(1/2, 4)
	, pch=20, cex=8
	, col = c(
		  rgb(1.0, 0, 0)
		, rgb(0.96, 0, 0.4)
		, rgb(0.93, 0, 0.7)
		, rgb(0.9, 0, 0.9)
	)
)

