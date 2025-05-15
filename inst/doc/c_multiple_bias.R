## ----chien--------------------------------------------------------------------
chien <- matrix(c(118, 832, 103, 884),
				dimnames = list(c("BC+", "BC-"), c("AD+", "AD-")),
				nrow = 2, byrow = TRUE)

## ----chien-tab, echo=FALSE----------------------------------------------------
knitr::kable(chien)

## ----misclass_chien-----------------------------------------------------------
library(episensr)
seq_bias1 <- chien %>%
	misclass(., type = "exposure",
			 bias_parms = c(24/(24+19), 18/(18+13), 144/(144+2), 130/(130+4)))
seq_bias1

## ----chien-tab-misclass-------------------------------------------------------
seq_bias1$corr_data

## ----misclass_sel-------------------------------------------------------------
seq_bias2 <- seq_bias1$corr_data %>%
	selection(., bias_parms = c(.734, .605, .816, .756))
seq_bias2

## ----chien-tab-selection------------------------------------------------------
seq_bias2$corr_data

## ----misclass_sel_conf--------------------------------------------------------
seq_bias3 <- seq_bias2$corr_data %>%
	confounders(., type = "OR", bias_parms = c(.8, .299, .436))
seq_bias3

## ----chien-tab-conf1----------------------------------------------------------
seq_bias3$cfder_data

## ----chien-tab-conf2----------------------------------------------------------
seq_bias3$nocfder_data

## ----multi_prob---------------------------------------------------------------
mod1 <- chien %>%
	probsens(., type = "exposure",
			 seca = list("trapezoidal", c(.45, .5, .6, .65)),
			 seexp = list("trapezoidal", c(.4, .48, .58, .63)),
			 spca = list("trapezoidal", c(.95, .97, .99, 1)),
			 spexp = list("trapezoidal", c(.96, .98, .99, 1)),
			 corr_se = .8, corr_sp = .8)
str(mod1)

## ----head_cells---------------------------------------------------------------
head(mod1$sim_df[, 5:8])

