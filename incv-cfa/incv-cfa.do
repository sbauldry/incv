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


*** Checking distributions of missing data
recode _all (-9 = .)

egen fnm1 = rowmiss(incissues incelec incdebate incpolicy)
egen rnm1 = rowmiss(incissues incelec incdebate incpolicy) if fchck1 == 2

tab fnm1
tab rnm1

egen fnm2 = rowmiss(incgrid incextreme increason incdanger incbipart ///
  incdistract incshift inccommon incdialog incthreat)
egen rnm2 = rowmiss(incgrid incextreme increason incdanger incbipart ///
  incdistract incshift inccommon incdialog incthreat) if fchck1 == 2
recode fnm2 rnm2 (5/10 = 5)
  
tab fnm2
tab rnm2

egen fnm3 = rowmiss(incbipart incdistract incshift inccommon incdialog)
egen rnm3 = rowmiss(incbipart incdistract incshift inccommon incdialog) ///
  if fchck1 == 2
recode fnm3 rnm3 (5/10 = 5)
  
tab fnm3
tab rnm3
