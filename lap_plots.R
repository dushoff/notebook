library(ggplot2); theme_set(theme_classic(base_size=12))
library(shellpipes)

laptime <- rdsRead()

summary(laptime)

alpha <- 0.1
print(ggplot(laptime)
	+ aes(x=lap, y=time, color=circuit)
	+ geom_point(alpha=alpha)
	+ geom_smooth()
	+ theme(legend.position = "none")
)
