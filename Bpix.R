library(ggplot2); theme_set(theme_bw(base_size=18))
library(shellpipes)

commandEnvironments()

print(ggplot(l)
	+ aes(week20, cases, color=strain)
	+ geom_point()
	+ geom_line()
	+ scale_y_log10()
)
