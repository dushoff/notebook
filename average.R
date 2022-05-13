library(shellpipes)
startGraphics(); par(cex=1.6)

ave <- read.table(matchFile(exts="out"))

with(ave, plot(V1, V2
	, xlab = "Batting average"
	, ylab = "Min. attempts"
	, type="l"
	, log="y"
))
