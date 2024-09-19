
L <- rep(1, 6)
Lp <- -2:3

for (i in 1:12){
	print(L)
	Lp <- Lp + L
	L <- Lp - L
}
