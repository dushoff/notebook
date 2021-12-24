
day <- 1

t <- (1:30)*day
t <- (1:45)*day

om0 <- 1
del0 <- 1000
omr <- 0.4/day
delr <- 0.1/day

om <- om0*exp(omr*t)
del <- del0*exp(delr*t) 

plot(t, om, type="l")
lines(t, del, col="blue")

prop <- om/(om+del)

plot(t, prop, type="l")
