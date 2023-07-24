//cd "/Users/scottganz/Dropbox/AEI/NBA/stata"
cd "/Users/kieranallsop/Library/CloudStorage/OneDrive-JohnsHopkins/Projects/NBA/GITHUB"

use "../data/nba_final_data.dta", clear

/*###############################
Set-up data
###############################*/

// Generate month variables
gen month2 = month(date)
drop month
gen month = month2
drop month2

gen year = year(date)

// Encode home and away teams
encode hometeam, gen(home)
encode awayteam, gen(away)

// Encode hometeam-season and awayteam-season dummies
egen hometeam_season = concat(hometeam season), punct(-)
egen awayteam_season = concat(awayteam season), punct(-)
encode hometeam_season, gen(home_season)
encode awayteam_season, gen(away_season)
encode matchup, gen(matchup_season)
drop hometeam_season awayteam_season matchup
tabulate month, gen(monthdummy)
egen seasonid=group(season)

// Create foul margin and divide attendance by 1000
gen foulmargin = home_PF - away_PF
replace attendance = attendance / 1000

sort hometeam season date

replace form10h = form10h*10
replace form10a = form10a*10

// Label variables
label variable homemargin "Home Margin"
label variable attendance "Attendance (1000 fans)"
label variable foulmargin "Foul Margin"
label variable cases100k2wk "Cases per 100k"
label variable death100k2wk "Deaths per 100k"
label variable form1h "Home Form"
label variable form5h "Home Form"
label variable form10h "Home Form"
label variable form1a "Away Form"
label variable form5a "Away Form"
label variable form10a "Away Form"
label variable republican "Republican Voting Proportion"

/*###############################
All Seasons Regressions - Table 4
TAKE LONG TO RUN - DO NOT RUN UNLESS NEEDED
###############################*/

/*
reg homemargin attendance i.month form10h form10a i.home_season i.away_season, robust
outreg2 using reg_results/regression_outputALL.tex, replace label keep(attendance form10h form10a)
ivreg2 homemargin i.month form10h form10a i.home_season i.away_season (attendance = capacity), robust
outreg2 using reg_results/regression_outputALL.tex, append label keep(attendance form10h form10a)
*/

/*###############################
Set-up data using 2021 only
###############################*/

// Keep only relevant observations
keep if season == "2021"

tabulate away, gen(awaydummy)

// Create binary and categorical attendance
gen attendanceb = 1 if attendance>0
replace attendanceb = 0 if attendanceb==.
gen capacityb = 1 if capacity>0
replace capacityb = 0 if capacityb==.
label variable attendanceb "Attendance (Yes or No)"
label variable capacityb "Capacity (Yes or No)"

gen attendancec = 0 if attendance==0
replace attendancec = 1 if attendance>0 & attendance<=3
replace attendancec = 2 if attendance>3
label variable attendancec "Attendance (Categories)"

gen attendance0 = 1 if attendance==0
replace attendance0 = 0 if attendance0==.
gen attendance1 = 1 if attendance>0 & attendance<=3
replace attendance1 = 0 if attendance1==.
gen attendance2 = 1 if attendance>3
replace attendance2 = 0 if attendance2==.
label variable attendance1 "Attendance (1-3000 Fans)"
label variable attendance2 "Attendance (Over 3000 Fans)"

gen capacity0 = 1 if capacity==0
replace capacity0=0 if capacity0==.
gen capacity1 = 1 if capacity>0 & capacity<=3000
replace capacity1=0 if capacity1==.
gen capacity2 = 1 if capacity>3000
replace capacity2=0 if capacity2==.
label variable capacity1 "Capacity (1-3000 Fans)"
label variable capacity2 "Capacity (Over 3000 Fans)"

xtset home gamenumber

/*###############################
Uncorrcted Regressions - Table 7
###############################*/

xtreg homemargin attendance i.away i.month form10h form10a cases100k2wk, fe robust
outreg2 using reg_results/regression_outputUNCORR.tex, replace label keep(attendance form10h form10a cases100k2wk)
xtivreg2 homemargin awaydummy* monthdummy* form10h form10a cases100k2wk (attendance = capacity) , fe robust
outreg2 using reg_results/regression_outputUNCORR.tex, append label keep(attendance form10h form10a cases100k2wk)
xtreg foulmargin attendance i.away i.month form10h form10a cases100k2wk, fe
outreg2 using reg_results/regression_outputUNCORR.tex, append label keep(attendance form10h form10a cases100k2wk)
xtivreg2 foulmargin awaydummy* monthdummy* form10h form10a cases100k2wk (attendance = capacity) , fe robust
outreg2 using reg_results/regression_outputUNCORR.tex, append label keep(attendance form10h form10a cases100k2wk)


drop if reg_remove==1

xtset home gamenumber

/*###############################
Preferred Regressions - Table 1
###############################*/

xtreg homemargin attendance i.away i.month form10h form10a cases100k2wk, fe robust
outreg2 using reg_results/regression_outputMAIN.tex, replace label keep(attendance form10h form10a cases100k2wk)
xtivreg2 homemargin awaydummy* monthdummy* form10h form10a cases100k2wk (attendance = capacity) , fe robust
outreg2 using reg_results/regression_outputMAIN.tex, append label keep(attendance form10h form10a cases100k2wk)
xtreg foulmargin attendance i.away i.month form10h form10a cases100k2wk, fe
outreg2 using reg_results/regression_outputMAIN.tex, append label keep(attendance form10h form10a cases100k2wk)
xtivreg2 foulmargin awaydummy* monthdummy* form10h form10a cases100k2wk (attendance = capacity) , fe robust
outreg2 using reg_results/regression_outputMAIN.tex, append label keep(attendance form10h form10a cases100k2wk)

/*###############################
Binary/Categorical Capacity Regressions - Table 3
###############################*/

xtreg homemargin capacityb i.away i.month form10h form10a cases100k2wk, fe robust
outreg2 using reg_results/regression_outputCAP.tex, replace label keep(capacityb form10h form10a cases100k2wk)
xtreg homemargin capacity1 capacity2 i.away i.month form10h form10a cases100k2wk, fe robust
outreg2 using reg_results/regression_outputCAP.tex, append label keep(capacity1 capacity2 form10h form10a cases100k2wk)


replace capacity = capacity/1000
gen cases1k2wk = cases100k2wk/100
label variable capacity "Capacity"
label variable attendance "Attendance" 
label variable cases1k2wk "Cases per 1000 People"

/*###############################
First-Stage Regressions - Table 2
###############################*/

xtreg attendance capacity i.away i.month form10h form10a cases1k2wk, fe
outreg2 using reg_results/regression_outputFIRST.tex, replace label keep(capacity form10h form10a cases1k2wk)
xtreg attendance capacity i.away i.month form10h form10a cases1k2wk, fe
outreg2 using reg_results/regression_outputFIRST.tex, append label keep(capacity form10h form10a cases1k2wk)

// First stage regs for F-stat values
xtivreg2 homemargin awaydummy* monthdummy* form10h form10a cases1k2wk (attendance = capacity) , fe robust first
xtivreg2 foulmargin awaydummy* monthdummy* form10h form10a cases1k2wk (attendance = capacity) , fe robust first
