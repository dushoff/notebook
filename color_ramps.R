library(shellpipes)
startGraphics()

n <- 11

for (t in levels(grDevices:::.hcl_colors_parameters$type)){
	for (name in sort(hcl.pals(type=t))){
		col <- hcl.colors(n = n, palette = name)
		pie(rep(1, n), col = col, main = name, sub=t)
	}
}
