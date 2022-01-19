cd "H:\DataSets4\Allsop\Dropbox\NBA\tex"
//cd "/Users/scottganz/Dropbox/AEI/NBA/stata"

use "..\data\nba_final_data.dta", clear
//use "../data/nba_final_data.dta", clear

gen month2 = month(date)
drop month
gen month = month2
drop month2

gen year = year(date)

encode hometeam, gen(homearena)
encode awayteam, gen(opponent)

egen hometeam_season = concat(hometeam season), punct(-)
egen awayteam_season = concat(awayteam season), punct(-)
gen foulmargin = home_PF - away_PF
replace attendance = attendance / 1000
encode hometeam_season, gen(Teams)
encode awayteam_season, gen(awaynumeric)
tabulate month, gen(monthdummy)

keep if season == "2021"
drop if reg_remove==1

tabulate awaynumeric, gen(awaydummy)

xtset Teams gamenumber
gen laghomemargin = homemargin[_n-1]
gen lagfoulmargin = foulmargin[_n-1]

label variable homemargin "Home Margin"
label variable attendance "Attendance (1000 fans)"
label variable laghomemargin "Home Margin Lag"
label variable lagfoulmargin "Foul Margin Lag"
label variable foulmargin "Foul Margin"

xtreg homemargin attendance i.awaynumeric i.month laghomemargin, fe robust
outreg2 using regression_output.tex, replace label keep(attendance laghomemargin)
xtivreg2 homemargin awaydummy* monthdummy* laghomemargin (attendance = capacity) , fe robust
outreg2 using regression_output.tex, append label keep(attendance laghomemargin)
xtreg foulmargin attendance i.awaynumeric i.month lagfoulmargin, fe
outreg2 using regression_output.tex, append label keep(attendance lagfoulmargin)
xtivreg2 foulmargin awaydummy* monthdummy* lagfoulmargin (attendance = capacity) , fe robust
outreg2 using regression_output.tex, append label keep(attendance lagfoulmargin)




