*** Purpose: Prepare data for fdpi analysis
*** Author: S Bauldry
*** Date: Feb 22, 2022

* loading data
use FCHCK1 WEIGHT CIV* using ~/desktop/incv-data if FCHCK1 == 2, replace

* lowercase for ease of programming
rename *, lower

* setting no opinion and prefer not to state to missing
recode civ* (89 99 = .)

* rescale weights
qui sum weight, detail
gen rwt = weight/r(sum)*r(N)
drop weight

* export data for analysis in Mplus
order civthreat civharm civslur civmislead civdisres civderog civvulgar ///
      civprevent civface civdemon civinsult civmakefun civexagg         ///
	  civintrupt civreflist civshout civcharac civevid civrolleye       ///
	  civstand civflame civliar civtroll civevanger civevfear civanger rwt
keep civthreat-rwt

* dropping cases missing on all indicators for model 1
egen nm = rowmiss(civthreat civharm civslur civmislead civdisres civderog    ///
                  civvulgar civprevent civface civdemon civinsult civmakefun ///
				  civexagg civintrupt civreflist civshout civcharac civevid  ///
				  civrolleye civstand)
drop if nm == 20

recode _all (. = -9)
desc
export delim using ~/desktop/incv-fdpi-mplus-data.csv, replace delim(",") novar nolab



