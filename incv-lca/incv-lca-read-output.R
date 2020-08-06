### Read LCA results from Mplus
### Author: S Bauldry
### Date: July 7, 2020

rm(list = ls())
library(tidyverse)
library(MplusAutomation)

### function to extract and prepare CIRPs
### need to parse 1 class a time to deal with duplicates
cirp <- function(f, l) {
  as_tibble(lca$parameters$probability.scale) %>%
    select(param:est) %>%
    slice(f:l) %>%
    spread(category, est)
}

### 3-class model
lca <- readModels("~/desktop/incv-lca-3.out") 
cirp_1 <- cirp(1, 85) %>% 
  rename(c11 = `1`, c12 = `2`, c13 = `3`, c14 = `4`, c15 = `5`)
cirp_2 <- cirp(86, 170) %>% 
  rename(c21 = `1`, c22 = `2`, c23 = `3`, c24 = `4`, c25 = `5`)
cirp_3 <- cirp(171, 255) %>% 
  rename(c31 = `1`, c32 = `2`, c33 = `3`, c34 = `4`, c35 = `5`)

lca_3_cirp_1 <- full_join(cirp_1, cirp_2, by = "param")
lca_3_cirp <- full_join(lca_3_cirp_1, cirp_3, by = "param") 

write_csv(lca_3_cirp, "~/desktop/incv-lca-3")


### 4-class model
lca <- readModels("~/desktop/incv-lca-4.out") 
cirp_1 <- cirp(1, 85) %>% 
  rename(c11 = `1`, c12 = `2`, c13 = `3`, c14 = `4`, c15 = `5`)
cirp_2 <- cirp(86, 170) %>% 
  rename(c21 = `1`, c22 = `2`, c23 = `3`, c24 = `4`, c25 = `5`)
cirp_3 <- cirp(171, 255) %>% 
  rename(c31 = `1`, c32 = `2`, c33 = `3`, c34 = `4`, c35 = `5`)
cirp_4 <- cirp(256, 340) %>% 
  rename(c41 = `1`, c42 = `2`, c43 = `3`, c44 = `4`, c45 = `5`)

lca_4_cirp_1 <- full_join(cirp_1, cirp_2, by = "param")
lca_4_cirp_2 <- full_join(lca_4_cirp_1, cirp_3, by = "param")
lca_4_cirp <- full_join(lca_4_cirp_2, cirp_4, by = "param") 

write_csv(lca_4_cirp, "~/desktop/incv-lca-4")


### 5-class model
lca <- readModels("~/desktop/incv-lca-5.out") 
cirp_1 <- cirp(1, 85) %>% 
  rename(c11 = `1`, c12 = `2`, c13 = `3`, c14 = `4`, c15 = `5`)
cirp_2 <- cirp(86, 170) %>% 
  rename(c21 = `1`, c22 = `2`, c23 = `3`, c24 = `4`, c25 = `5`)
cirp_3 <- cirp(171, 255) %>% 
  rename(c31 = `1`, c32 = `2`, c33 = `3`, c34 = `4`, c35 = `5`)
cirp_4 <- cirp(256, 340) %>% 
  rename(c41 = `1`, c42 = `2`, c43 = `3`, c44 = `4`, c45 = `5`)
cirp_5 <- cirp(341, 425) %>% 
  rename(c51 = `1`, c52 = `2`, c53 = `3`, c54 = `4`, c55 = `5`)

lca_5_cirp_1 <- full_join(cirp_1, cirp_2, by = "param")
lca_5_cirp_2 <- full_join(lca_5_cirp_1, cirp_3, by = "param")
lca_5_cirp_3 <- full_join(lca_5_cirp_2, cirp_4, by = "param")
lca_5_cirp <- full_join(lca_5_cirp_3, cirp_5, by = "param") 

write_csv(lca_5_cirp, "~/desktop/incv-lca-5")


