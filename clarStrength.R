library(ggplot2); theme_set(theme_bw(base_size=14))
library(dplyr)

library(shellpipes)
startGraphics()

largeEffect=1.4
smallEffect=0.4
tinyEffect = 0.1
smallVar = 0.2
medVar = 0.5
largeVar = 0.8
hugeVar = 1.2

vget = Vectorize(get)

vf <- (
	read.csv(strip.white=TRUE, text="
		pic, val, unc
		PL, largeEffect, smallVar
		PU, largeEffect, largeVar
		PS, smallEffect, smallVar
		US, tinyEffect, medVar
		UU, smallEffect, largeVar
		nopower, tinyEffect, hugeVar
	")
	%>% mutate(NULL
		, val = vget(val)
		, unc = vget(unc)
		, lwr = val-unc
		, upr = val+unc
	)
)

print(ggplot(vf)
	+ aes(pic, val)
	+ geom_point()
	+ coord_flip()
	+ geom_hline(xintercept=1)
)
