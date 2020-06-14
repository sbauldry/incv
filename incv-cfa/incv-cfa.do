*** Purpose: Conduct CFA analysis outlined by Robin in June 9 memo
*** Author: S Bauldry
*** Date: June 13, 2020

*** Loading data
use WEIGHT INCGRID INCEXTREME INCISSUES INCREASON INCELEC INCDANGER     ///
  INCBIPART INCDEBATE INCDISTRACT INCPOLICY INCSHIFT INCCOMMON INCDIALOG ///
  INCTHREAT INCINCLUSIVE INCNECESS INCTRUTH TOLBOTHER TOLUPSET INCHEARD ///
  INCINST INCNOPLACE INCDIGNITY TOLAVOID TOLBRUSH                       ///
  using ~/desktop/incv-data, replace

* lowercase for ease of programming
rename *, lower

* rescale weights
qui sum weight, detail
gen rwt = weight/r(sum)*r(N)
drop weight

* setting no opinion and prefer not to state to same missing value
recode _all (89 99 = -9)

* recode selected variables
recode incissues incelec incdebate incpolicy incinclusive incnecess inctruth ///
  inchear incinst incnoplace incdignity (4 = 1) (3 = 2) (2 = 3) (1 = 4)
  
* saving data for analysis in Mplus
desc 
export delim using ~/desktop/incv-data.csv, replace delim(",") novar nolab



*** Calculating omegas for Analysis 1

* Good consequences indicators
mata:

// enter estimates from Mplus
lam = (0.721, 0.774, 0.779, 0.780)
tau = (-0.516, 0.378, 1.314 \  0.010, 0.906, 1.616 \ ///
       -0.707, 0.308, 1.443 \ -0.234, 0.788, 1.550)
pcm = (1.000, 0.593, 0.569, 0.514 \ 0.593, 1.000, 0.558, 0.612 \ ///
       0.569, 0.558, 1.000, 0.628 \ 0.514, 0.612, 0.628, 1.000)

// computing terms
bvn = J(144, 6, .)
uvn = J(48, 5, .)

m = 1
n = 1
for(j = 1; j <= 4; j++) {
  for(jp = 1; jp <= 4; jp++) {
  	for(c = 1; c <= 3; c++) {
	  
	  uvn[n,1] = j
	  uvn[n,2] = jp
	  uvn[n,3] = c
	  uvn[n,4] = normal(tau[j,c])
	  uvn[n,5] = normal(tau[jp,c])
	  n++
		
	  for(cp = 1; cp <= 3; cp++) {
        
		bvn[m,1] = j
		bvn[m,2] = jp
		bvn[m,3] = c
		bvn[m,4] = cp
		bvn[m,5] = binormal(tau[j,c],tau[jp,cp],lam[j]*lam[jp])
		bvn[m,6] = binormal(tau[j,c],tau[jp,cp],pcm[j,jp])
		m++	  
	  
	  }
	}
  }
}

// computing sums over c and c'
csm = J(16, 4, .)
for(j = 1; j <= 16; j++){
  a = j + (j - 1)*8
  b = a + 8
  c = j + (j - 1)*2
  d = c + 2
  
  csm[j,.] = colsum(bvn[a..b, 5]), colsum(bvn[a..b, 6]), colsum(uvn[c..d, 4]), colsum(uvn[c..d, 5]) 
}

// computing sums over j and j'
csmt = J(16, 2, .)
csmt[.,1] = csm[.,1] - csm[.,3]:*csm[.,4]
csmt[.,2] = csm[.,2] - csm[.,3]:*csm[.,4]

jsm = colsum(csmt)

jsm

// display omega
jsm[1,1]/jsm[1,2]

end


* Bad consequences indicators
mata:

// enter estimates from Mplus
lam = (0.651, 0.690, 0.677, 0.642, 0.756, 0.803, 0.746, 0.758, 0.747, 0.702)

tau = (-0.513,0.676,1.334 \ ///
       -0.296,0.737,1.350 \ ///
       -0.330,0.662,1.321 \ ///
       -0.447,0.590,1.252 \ ///
       -0.211,0.853,1.617 \ ///
       -0.178,1.035,1.765 \ ///
       -0.221,1.005,1.769 \ ///
       -0.208,0.932,1.628 \ ///
        0.019,1.072,1.717 \ ///
       -0.225,1.038,1.595)
	   
pcm = (1.000,0.557,0.534,0.471,0.473,0.469,0.430,0.440,0.426,0.388 \ ///
       0.557,1.000,0.516,0.520,0.492,0.514,0.471,0.485,0.461,0.456 \ ///
       0.534,0.516,1.000,0.466,0.519,0.502,0.473,0.483,0.482,0.423 \ ///
       0.471,0.520,0.466,1.000,0.442,0.486,0.418,0.421,0.458,0.496 \ ///
       0.473,0.492,0.519,0.442,1.000,0.601,0.556,0.620,0.577,0.524 \ ///
       0.469,0.514,0.502,0.486,0.601,1.000,0.655,0.613,0.622,0.567 \ ///
       0.430,0.471,0.473,0.418,0.556,0.655,1.000,0.573,0.561,0.546 \ ///
       0.440,0.485,0.483,0.421,0.620,0.613,0.573,1.000,0.596,0.546 \ ///
       0.426,0.461,0.482,0.458,0.577,0.622,0.561,0.596,1.000,0.545 \ ///
       0.388,0.456,0.423,0.496,0.524,0.567,0.546,0.546,0.545,1.000)


// computing terms
bvn = J(900, 6, .)
uvn = J(300, 5, .)

m = 1
n = 1
for(j = 1; j <= 10; j++) {
  for(jp = 1; jp <= 10; jp++) {
  	for(c = 1; c <= 3; c++) {
	  
	  uvn[n,1] = j
	  uvn[n,2] = jp
	  uvn[n,3] = c
	  uvn[n,4] = normal(tau[j,c])
	  uvn[n,5] = normal(tau[jp,c])
	  n++
		
	  for(cp = 1; cp <= 3; cp++) {
        
		bvn[m,1] = j
		bvn[m,2] = jp
		bvn[m,3] = c
		bvn[m,4] = cp
		bvn[m,5] = binormal(tau[j,c],tau[jp,cp],lam[j]*lam[jp])
		bvn[m,6] = binormal(tau[j,c],tau[jp,cp],pcm[j,jp])
		m++	  
	  
	  }
	}
  }
}

// computing sums over c and c'
csm = J(100, 4, .)
for(j = 1; j <= 100; j++){
  a = j + (j - 1)*8
  b = a + 8
  c = j + (j - 1)*2
  d = c + 2
  
  csm[j,.] = colsum(bvn[a..b, 5]), colsum(bvn[a..b, 6]), colsum(uvn[c..d, 4]), colsum(uvn[c..d, 5]) 
}

// computing sums over j and j'
csmt = J(100, 2, .)
csmt[.,1] = csm[.,1] - csm[.,3]:*csm[.,4]
csmt[.,2] = csm[.,2] - csm[.,3]:*csm[.,4]

jsm = colsum(csmt)

jsm

// display omega
jsm[1,1]/jsm[1,2]

end




