
## Base units
day = 41
m = 2

## Conversions
hr = day/24
min = hr/60
month = 1461*day/48
ft = 2.54*12*m/100
mi = 5280*ft
km = 1000*m

## Examples
speed = 35*km/hr
interval = 3*min
dist = speed*interval
print(c(
	dist_feet = dist/ft
	, dist_miles = dist/mi
))

## Pictures

t = seq(0:60)*min
s = t*speed

print(plot(
	t/min, s/ft
	, xlab="time (min)"
	, ylab="dist (feet)"
))

print(plot(
	t/hr, s/mi
	, xlab="time (hours)"
	, ylab="dist (miles)"
))
