library(dplyr)
library(ggplot2); theme_set(theme_classic())

library(shellpipes)
rpcall("statclar.stat.Rout statstrength.R statstrength.tsv statclar.desc.tsv")
rpcall("statstrength.clarity.Rout statstrength.R statstrength.tsv clarity.desc.tsv")

dat <- (tsvRead("statstrength")
	%>% full_join(tsvRead("desc"))
	%>% mutate(NULL
		, y = -(1:length(fig))
		, x = (low + high)/2
		, description = gsub("[|]", "\n", description)
	)
)

summary(dat)

sig = "importance\nthreshold"
right = 5
errheight = 0.25
tstart = 2
tkern = 0.2
tpos = max(max(dat$high)+tkern, tstart)
rcolor = "black"
ralpha = 0.1
rkern = 0.1

(ggplot(dat)
	+ aes(x=x, y=y, xmin=low, xmax=high)
	+ geom_errorbarh(aes(height=errheight))
	+ geom_vline(xintercept=0, lty=2)
	+ geom_text(aes(x=tpos, label=description, hjust="left"))
	+ scale_y_continuous(breaks=NULL)
	+ scale_x_continuous(breaks = -1:1
		, labels=c(sig, "0", sig)
		, limits = c(NA, right)
	)
	+ xlab("") + ylab("")
	+ theme(axis.line.y = element_blank())
	+ annotate("rect", xmin=-Inf, xmax =-1
		, fill=rcolor, alpha=ralpha, ymin=-Inf, ymax=Inf
	)
	+ annotate("rect", xmin=1, xmax = tstart-rkern
		, fill=rcolor, alpha=ralpha, ymin=-Inf, ymax=Inf
	)
) %>% teeGG(ext="png", print_title="")
