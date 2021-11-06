*** Purpose: Prepare data for replication files
*** Author: S Bauldry
*** Date: Sep 30, 2021

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

* export data for analysis in R
order civthreat civharm civslur civmislead civdisres civderog civvulgar ///
      civprevent civface civdemon civinsult civmakefun civexagg         ///
	  civintrupt civreflist civshout civcharac civevid civrolleye       ///
	  civstand rwt
keep civthreat-rwt
export delim using ~/desktop/incv-hcr-data.csv, replace delim(",") nolab


	   
* save data for analysis in mplus
recode _all (. = -9)
desc
export delim using ~/desktop/incv-hcr-mplus-data.csv, replace delim(",") novar nolab
