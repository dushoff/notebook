library(ggplot2); theme_set(theme_bw(base_size=18))
library(dplyr)
library(shellpipes)

commandEnvironments()

startGraphics()

print(ggplot(gammA)
	+ aes(obsWeek, cases, color=strain)
	+ geom_point()
	+ geom_line(aes(y=exp(.fitted)))
	+ scale_y_log10()
)
