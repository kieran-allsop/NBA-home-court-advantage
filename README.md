# NBA-home-court-advantage

This repository contains all of the hand-collected data and code to reproduce the figures, analysis, and calculations in the journal article **"[A Mere Fan Effect on Home Court Advantage
](https://www.aei.org/research-products/working-paper/all-star-fans-and-home-court-advantage/)"** published on ??? ?th, 2023, and the FiveThirtyEight article **"[After This Weird NBA Season, We Have A Better Idea Of How Much Fans Matter](https://fivethirtyeight.com/features/after-this-weird-nba-season-we-have-a-better-idea-of-how-much-fans-matter/)"**, published July 6th, 2021.

Data collection from [basketball-reference.com](https://www.basketball-reference.com/) was originally completed in May 2021 and then updated in May 2022 to include the 2021-22 season and all COVID-19 data. It is possible that data access may have changed since the analysis was conducted. The full data set used for the journal article can be found in the data file under either **[nba_final_data.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/nba_final_data.csv)** or **[nba_final_data.dta](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/nba_final_data.dta)**. All analysis and figure production can be obtained from these datasets.

**[nba_replication_2307.Rmd](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/NBA_replication_2307.Rmd)** includes the code to scrape and combine the data from [basketball-reference.com](https://www.basketball-reference.com/). It then reproduces each of the figures and calculates all statistical claims made in the journal article. [nba_replication_2307.html](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/NBA_replication_2307.html) is a HTML version of the same document.

**[NBA_replication_2307_stata.do](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/NBA_replication_2307_stata.do)** conducts all of the regression analysis found in the journal article following the successful scraping and merging of the data set. 

Reproduction of the figures and an all statisitcal claims made in the FiveThirtyEight article can be found in either **[NBA_replication_538Article.Rmd](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/NBA_replication_538Article.Rmd)** or [NBA_replication_538Article.html](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/NBA_replication_538Article.html).

Below we list the other data sets found in the data folder:
* **[boxscore_stats_home.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/boxscore_stats_home.csv)** and **[boxscore_stats_away.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/boxscore_stats_away.csv)** contain team boxscore statistics for each season from 2014-15 to 2020-22, collected from [basketball-reference.com](https://www.basketball-reference.com/).
* **[censusbureau_popdata2021.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/censusbureau_popdata2021.csv)** contains county-level population data for 2021 and is taken from [United States Census Bureau](https://data.census.gov/).
* **[covid_cases_byTeam.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/covid_cases_byTeam.csv)** is a created data set calculating COVID-19 case rates and death rates in the counties of NBA stadia using the [censusbureau_popdata2021.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/censusbureau_popdata2021.csv) data set, the [stadium_counties.xlsx](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/stadium_counties.xlsx) data set, and the COVID-19 case data ([us-counties-2020-covidcases.csv.zip](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2020-covidcases.csv.zip), [us-counties-2021-covidcases.csv.zip](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2021-covidcases.csv.zip), and [us-counties-2022-covidcases.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2022-covidcases.csv)).
* **[stadium_capacity_limits.xlsx](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/stadium_capacity_limits.xlsx)** contains hand-collected data on stadium capacity limits throughout the 2020-21 season. The various sources of this data can be found within the file.
* **[stadium_counties.xlsx](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/stadium_counties.xlsx)** lists the counties in which each teams' stadia were located during the 2020-21 season including FIPS codes.
* **[us-counties-2020-covidcases.csv.zip](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2020-covidcases.csv.zip), [us-counties-2021-covidcases.csv.zip](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2021-covidcases.csv.zip),** and **[us-counties-2022-covidcases.csv](https://github.com/kieran-allsop/NBA-home-court-advantage/blob/main/Replication/data/us-counties-2022-covidcases.csv)** contain COVID-19 case and death data taken from [the New York Times](https://github.com/nytimes/covid-19-data) for the years 2020, 2021, and 2022.

_Note that a working paper version of the journal article was published on July 7th 2021 as an AEI working paper under the name "All-star Fans and Home Court Advantage and can be found [here](https://www.aei.org/research-products/working-paper/all-star-fans-and-home-court-advantage/)._
