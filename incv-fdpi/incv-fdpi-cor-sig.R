### Purpose: calculate p-values for correlations < 1
### Author:  S Bauldry
### Date:    Feb 22, 2022

### Function to calculate p-value
r_pval <- function(est, se) {
  z <- (1 - est)/se
  p <- 2*(1 - pnorm(z))
  c(est, se, z, p)
}

### Correlations and standard errors from Mplus

# r(Discursive, Utterance) = 0.965 (0.006)
r_pval(0.965, 0.006)

# r(Deception, Discursive) = 0.948 (0.014)
r_pval(0.948, 0.014)

# r(Discursive, Negative Emotion) = 0.904 (0.012)
r_pval(0.904, 0.012)

# r(Deception, Utterance) = 0.882 (0.014)
r_pval(0.882, 0.014)

# r(Utterance, Negative Emotion) = 0.937 (0.009)
r_pval(0.937, 0.009)

# r(Deception, Negative Emotion) = 0.926 (0.014)
r_pval(0.926, 0.014)






