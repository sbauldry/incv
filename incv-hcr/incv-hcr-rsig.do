*** Purpose: calculate signifance tests for CFA correlations
*** Author:  S Bauldry
*** Date:    Nov 18, 2020

*** Function calculates z-statistic as (1 - correlation)/standard error
*** And calculates p-values for that z-statistic
*** H_0: r = 1, H_a: r != 1
capture program drop rsig
program rsig
  args r stderr
  
  local z = (1 - `r')/`stderr'
  local p = 2*(1 - normal(`z'))
  
  dis "z = " `z' " with p-value = " `p'
end



*** Estimates from Mplus incv-hcr-m4.out
* Deception / Discursive: r = 0.948, se = 0.014
rsig 0.948 0.014

* Utterance / Discursive: r = 0.965, se = 0.006
rsig 0.971 0.006

* Utterance / Deception: r = 0.882, se = 0.014
rsig 0.878 0.014




