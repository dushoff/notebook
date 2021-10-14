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
	pit <- d %>% filter(!is.na(pit_time))
	print(ggplot(d)
		+ aes(x=lap, y=time)
		+ geom_point()
		+ geom_line()
		+ ggtitle(paste(.data$race, .data$year))
		+ geom_point(color="lightsalmon2", data=pit)
	)
}

laptime %>% group_split(year, race) %>% walk(racePlot)

## split(laptime, ~year+race) should also work!

