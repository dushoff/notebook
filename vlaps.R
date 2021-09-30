library(shellpipes)
library(dplyr)
library(forcats)

vlap <- (csvRead("drivers")
	%>% filter(surname=="Verstappen")
	%>% left_join(csvRead("times"))
	%>% left_join(csvRead("races"), by="raceId")
	%>% left_join(csvRead("circuits"), by="circuitId")
	%>% left_join(csvRead("pit"), by=c("raceId", "driverId", "lap"))
	%>% filter(year >= 2018)
	%>% transmute(NULL
		, race=name.x, circuit=name.y
		, year, lap, position, time=milliseconds.x/1000
		, pit_time=milliseconds.y/1000
	)
	%>% mutate(across(where(is.character), ~fct_rev(fct_infreq(.))))
	%>% filter(time<300)
)
summary(vlap)
csvSave(vlap)
rdsSave(vlap)
