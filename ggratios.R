library(ggplot2); theme_set(theme_bw())

scale_y_ratio <- function (name = waiver(), breaks = waiver(), minor_breaks = waiver(), 
	n.breaks = NULL, labels = waiver(), limits = NULL, expand = waiver(), 
	oob = censor, na.value = NA_real_, trans = "identity", guide = waiver(), 
	position = "left", sec.axis = waiver()) 
{
	sc <- ratio_scale(ggplot_global$y_aes, "position_c", 
		identity, name = name, breaks = breaks, n.breaks = n.breaks, 
		minor_breaks = minor_breaks, labels = labels, limits = limits, 
		expand = expand, oob = oob, na.value = na.value, trans = trans, 
		guide = guide, position = position, super = ScaleContinuousPosition)
	set_sec_axis(sec.axis, sc)
}

ratio_scale <- function (aesthetics, scale_name, palette, name = waiver(), breaks = waiver(), 
	minor_breaks = waiver(), n.breaks = NULL, labels = waiver(), 
	limits = NULL, rescaler = rescale, oob = censor, expand = waiver(), 
	na.value = NA_real_, trans = "identity", guide = "legend", 
	position = "left", super = ScaleContinuous) 
{
 	continuous_scale(ggplot_global$y_aes, "position_c", 
	  identity, name = name, breaks = breaks, n.breaks = n.breaks, 
	  minor_breaks = minor_breaks, labels = labels, limits = limits, 
	  expand = expand, oob = oob, na.value = na.value, trans = trans, 
	  guide = guide, position = position, super = ScaleContinuousPosition)
}

d <- data.frame(
	x=1:10,
	y=10:1
)

print(ggplot(d)
	+ aes(x, y)
	+ geom_point()
	+ scale_y_ratio()
)
