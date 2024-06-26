
a <- 3
b <- 1:8

plot(b, a^b
	, log="y"
)

lines(b, b^(a+1))
