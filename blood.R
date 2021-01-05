
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
theme_set(theme_bw())

col <- c("#44FF44", "#6666FF", "#FF6666")

wbc_floor <- 4.5
wbc_high <- 13
wbc_norm <- sqrt(wbc_floor*wbc_high)
anc_floor <- 1800
anc_high <- 8000
anc_norm <- sqrt(anc_floor*anc_high)

wbc_text = paste("wbc range", wbc_floor, "-", wbc_high)

symPlot <- 6
shotPlot <- 9

xs <- input_files[[1]]
Tests <- read_excel(xs, sheet=1)
Symptoms <- read_excel(xs, sheet=2)
Shots <- read_excel(xs, sheet=3)

Tests <- (Tests
	%>% mutate(
		wbc = wbc/wbc_norm
		, anc = anc/anc_norm
	)
	%>% filter(date > as.POSIXct("2019-03-01"))
)

longTests <- (Tests
	%>% select(date, wbc, anc)
	%>% gather("Normalized value", "level", -date)
)

Symptoms$height <- symPlot
Shots$height <- shotPlot

mainPlot <- (
	ggplot(longTests, aes(x=date, y=level, color=`Normalized value`))
	+ scale_color_manual(values=col)
	+ scale_size_area()
	+ geom_line()
	+ geom_point()
	+ scale_y_log10()
	+ geom_hline(yintercept=c(anc_high/anc_norm, anc_floor/anc_norm)
		, linetype="dashed", color=col[1]
	)
	+ geom_hline(yintercept=c(wbc_high/wbc_norm, wbc_floor/wbc_norm)
		, linetype="dashed", color=col[2]
	)
	+ geom_point(data=Symptoms, aes(color=NULL, y=height, size=illness)
		, color=col[[3]]
	)
	+ geom_point(data=Shots, aes(color=NULL, y=height, group="shots"))
	## tag is a hack because I don't want to figure out how to position 
	## things properly on the date axis
	## but I could do this with the POSIXct code below, presumably
	+ labs(tag = "Shots") + theme(plot.tag.position = c(0.86, 0.96))
)

print(mainPlot)
print(mainPlot + xlim(c(as.POSIXct("2019-08-01"), NA)))
print(mainPlot + xlim(c(as.POSIXct("2019-12-01"), NA)))

## Does not work because of extra data sets
## print(mainPlot %+% filter(longTests, date>as.POSIXct("2020-01-01")))

print(Shots, n=100)
