*** Purpose: Prepare data for incivility LCA
*** Author: S Bauldry
*** Date: June 28, 2020

* loading data
use FCHCK1 WEIGHT CIVVULGAR CIVMISLEAD CIVDISRES CIVEVID CIVPREVENT CIVFACE  ///
  CIVMAKEFUN CIVINTRUPT CIVROLLEYE CIVDEMON CIVDEROG CIVCHARAC CIVINSULT     ///
  CIVREFLIST CIVSHOUT CIVEXAGG CIVSTAND pid using ~/desktop/incv-data        ///
  if [FCHCK1 == 2], replace

* lowercase for ease of programming
rename *, lower

* setting no opinion and prefer not to state to missing
recode civvulgar-civexagg (89 99 = .)

* rescale weights
qui sum weight, detail
gen rwt = weight/r(sum)*r(N)
drop weight

* checking distribution of missing data
egen nm = rowmiss(civvulgar-civexagg)
drop if nm == 17

* value labels for plots
lab def c 0 "N" 1 "Sl" 2 "So" 3 "M" 4 "V"
lab val civvulgar-civexagg c

* program to generate bar charts
capture program drop BC
program BC
  args v
  
  preserve
  qui sum `v'
  qui gen prp = 1/r(N)*rwt
  
  graph bar (sum) prp, over(`v') scheme(s1color) title("`v'")   ///
    ylab(0(0.2)1, angle(h) grid gstyle(dot)) ytit("proportion") ///
	saving("`v'", replace)
end

foreach x of varlist civvulgar-civexagg {
  BC `x'
}

graph combine civvulgar.gph civmislead.gph civdisres.gph civevid.gph ///
  civprevent.gph civface.gph civmakefun.gph civintrupt.gph civrolleye.gph ///
  civdemon.gph civderog.gph civcharac.gph civinsult.gph civreflist.gph ///
  civshout.gph civexagg.gph civstand.gph, rows(4) scheme(s1color)
graph export ~/desktop/incv-lca-fig1.jpg, replace


* save data for analysis in Mplus
drop fchck1
recode civvulgar-civexagg (. = -9)
desc
export delim using ~/desktop/incv-lca-data.csv, replace delim(",") novar nolab
