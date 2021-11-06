### Purpose: To produce analyses reported in HCR replication note
### Author:  S Bauldry
### Date:    Sep 30, 2021

### set working directory and load packages
setwd("~/desktop")
library(tidyverse)
library(weights)
library(lavaan)


### load data extract with analysis variables
incv <- read_csv("incv-hcr-data.csv")


### Table 2: Item distributions
threaten_harm      <- wpct(incv$civthreat, weight = incv$rwt)
encourage_harm     <- wpct(incv$civharm, weight = incv$rwt)
slur               <- wpct(incv$civslur, weight = incv$rwt)
mislead            <- wpct(incv$civmislead, weight = incv$rwt)
disrespect         <- wpct(incv$civdisres, weight = incv$rwt)
name_calling       <- wpct(incv$civderog, weight = incv$rwt)
vulgarity          <- wpct(incv$civvulgar, weight = incv$rwt)
prevent_discussion <- wpct(incv$civprevent, weight = incv$rwt)
violate_space      <- wpct(incv$civface, weight = incv$rwt)
demonize           <- wpct(incv$civdemon, weight = incv$rwt)
insult             <- wpct(incv$civinsult, weight = incv$rwt)
make_fun           <- wpct(incv$civmakefun, weight = incv$rwt)
exaggerate         <- wpct(incv$civexagg, weight = incv$rwt)
interrupt          <- wpct(incv$civintrupt, weight = incv$rwt)
refuse_to_listen   <- wpct(incv$civreflist, weight = incv$rwt)
shout              <- wpct(incv$civshout, weight = incv$rwt)
attack_character   <- wpct(incv$civcharac, weight = incv$rwt)
no_evidence        <- wpct(incv$civevid, weight = incv$rwt)
roll_eyes          <- wpct(incv$civrolleye, weight = incv$rwt)
attack_issues      <- wpct(incv$civstand, weight = incv$rwt)

table2 <- rbind(threaten_harm, encourage_harm, slur, mislead, disrespect, 
                 name_calling, vulgarity, prevent_discussion, violate_space,
                 demonize, insult, make_fun, exaggerate, interrupt, 
                 refuse_to_listen, shout, attack_character, no_evidence,
                 roll_eyes, attack_issues)
write_csv(data.frame(table2), "incv-hrc-table2.csv")
