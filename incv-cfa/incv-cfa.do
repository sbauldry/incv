*** Purpose: Prepare data for CFA analysis outlined by Robin in June 9 memo
*** Author: S Bauldry
*** Date: June 13, 2020

*** Loading data
use FCHCK1 WEIGHT INCGRID INCEXTREME INCISSUES INCREASON INCELEC INCDANGER ///
  INCBIPART INCDEBATE INCDISTRACT INCPOLICY INCSHIFT INCCOMMON INCDIALOG   ///
  INCTHREAT INCINCLUSIVE INCNECESS INCTRUTH TOLBOTHER TOLUPSET INCHEARD    ///
  INCINST INCNOPLACE INCDIGNITY TOLAVOID TOLBRUSH                          ///
  using ~/desktop/incv-data, replace

* lowercase for ease of programming
rename *, lower

* setting no opinion and prefer not to state to same missing value
recode _all (89 99 = -9)

* rescale weights
qui sum weight, detail
gen rwt = weight/r(sum)*r(N)
drop weight

* recode selected variables
recode incissues incelec incdebate incpolicy incinclusive incnecess inctruth ///
  inchear incinst incnoplace incdignity (4 = 1) (3 = 2) (2 = 3) (1 = 4)
  
* saving data for analysis in Mplus and R
desc 
export delim using ~/desktop/incv-data.csv, replace delim(",") novar nolab
