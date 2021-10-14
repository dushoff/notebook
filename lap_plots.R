library(dplyr)
library(purrr)
library(ggplot2); theme_set(theme_classic(base_size=12))
library(shellpipes)

laptime <- rdsRead()

summary(laptime)

## Overview
alpha <- 0.1
print(ggplot(laptime)
	+ aes(x=lap, y=time, color=circuit)
	+ geom_point(alpha=alpha)
	+ geom_smooth()
	+ theme(legend.position = "none")
)

## One race at a time
racePlot <- function(d){
	print(ggplot(d)
		+ aes(x=lap, y=time)
		+ geom_point()
		+ geom_line()
		+ ggtitle("Marquis")
	)
}

laptime %>% group_split(year, race) %>% walk(racePlot)

