## Uniform test, multiply success odds by r

r = 2.25
m = 1.05

curve(r*x/(1-x+r*x)/x, from=0, to=1, col="blue")
## curve(m*x, add=TRUE)
curve((sqrt(324*x^2-324*x+121)+22*x-11)/(sqrt(324*x^2-324*x+121)+18*x-7)/x
	, add=TRUE
)

