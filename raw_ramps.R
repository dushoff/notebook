library(shellpipes)
startGraphics()

tau <- 360
n <- 15
v <- 1:n
angles <- tau*(2*v-1)/(2*n)

col <- hcl(h = angles)
pie(rep(1, n), col = col)
print(col)
