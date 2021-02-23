## ----chien--------------------------------------------------------------------
chien <- matrix(c(118, 832, 103, 884),
                dimnames = list(c("BC+", "BC-"), c("AD+", "AD-")),
                nrow = 2, byrow = TRUE)

## ----chien-tab, echo=FALSE----------------------------------------------------
knitr::kable(chien)

## ----misclass_chien-----------------------------------------------------------
library(episensr)
chien %>%
    misclassification(., type = "exposure", bias_parms = c(.56, .58, .99, .97))

## ----misclass_sel-------------------------------------------------------------
chien %>% 
    misclassification(., type = "exposure", bias_parms = c(.56, .58, .99, .97)) %>%
    multiple.bias(., bias_function = "selection", bias_parms = c(.73, .61, .82, .76))

## ----misclass_sel_conf--------------------------------------------------------
chien %>%
    misclassification(., type = "exposure", bias_parms = c(.56, .58, .99, .97)) %>%
    multiple.bias(., bias_function = "selection",
                  bias_parms = c(.73, .61, .82, .76)) %>%
    multiple.bias(., bias_function = "confounders",
                  type = "OR", bias_parms = c(.92, .3, .44))

## ----multi_prob---------------------------------------------------------------
set.seed(123)
mod1 <- chien %>%
    probsens(., type = "exposure", reps = 100000,
             seca.parms = list("trapezoidal", c(.45, .5, .6, .65)),
             seexp.parms = list("trapezoidal", c(.4, .48, .58, .63)),
             spca.parms = list("trapezoidal", c(.95, .97, .99, 1)),
             spexp.parms = list("trapezoidal", c(.96, .98, .99, 1)),
             corr.se = .8, corr.sp = .8)
mod1

## ----plot2, warning=FALSE,message=FALSE,fig.width=6,fig.height=4--------------
plot(mod1, "or")

## ----multi_prob2--------------------------------------------------------------
set.seed(123)
mod2 <- chien %>%
    probsens.sel(., reps = 100000,
                 case.exp = list("beta", c(8.08, 24.25)),
                 case.nexp = list("trapezoidal", c(.75, .85, .95, 1)),
                 ncase.exp = list("beta", c(12.6, 50.4)),
                 ncase.nexp = list("trapezoidal", c(0.7, 0.8, 0.9, 1)))
mod2

## ----plot3, warning=FALSE,message=FALSE,fig.width=6,fig.height=4--------------
plot(mod2, "or")

## ----multi_prob3--------------------------------------------------------------
set.seed(123)
mod3 <- chien %>%
    probsens.conf(., reps = 100000,
                  prev.exp = list("beta", c(24.9, 58.1)),
                  prev.nexp = list("beta", c(42.9, 54.6)),
                  risk = list("trapezoidal", c(.2, .58, 1.01, 1.24)))
mod3

## ----plot4, message=FALSE, warning=FALSE,fig.width=6,fig.height=4-------------
plot(mod3, "or")

## ----multi_ms-----------------------------------------------------------------
set.seed(123)
chien %>%
    probsens(., type = "exposure", reps = 100000,
             seca.parms = list("trapezoidal", c(.45, .5, .6, .65)),
             seexp.parms = list("trapezoidal", c(.4, .48, .58, .63)),
             spca.parms = list("trapezoidal", c(.95, .97, .99, 1)),
             spexp.parms = list("trapezoidal", c(.96, .98, .99, 1)),
             corr.se = .8, corr.sp = .8) %>%
    multiple.bias(., bias_function = "probsens.sel",
                  case.exp = list("beta", c(8.08, 24.25)),
                  case.nexp = list("trapezoidal", c(.75, .85, .95, 1)),
                  ncase.exp = list("beta", c(12.6, 50.4)),
                  ncase.nexp = list("trapezoidal", c(0.7, 0.8, 0.9, 1)))

## ----multi_msc----------------------------------------------------------------
set.seed(123)
mod6 <- chien %>%
    probsens(., type = "exposure", reps = 100000,
             seca.parms = list("trapezoidal", c(.45, .5, .6, .65)),
             seexp.parms = list("trapezoidal", c(.4, .48, .58, .63)),
             spca.parms = list("trapezoidal", c(.95, .97, .99, 1)),
             spexp.parms = list("trapezoidal", c(.96, .98, .99, 1)),
             corr.se = .8, corr.sp = .8) %>%
    multiple.bias(., bias_function = "probsens.sel",
                  case.exp = list("beta", c(8.08, 24.25)),
                  case.nexp = list("trapezoidal", c(.75, .85, .95, 1)),
                  ncase.exp = list("beta", c(12.6, 50.4)),
                  ncase.nexp = list("trapezoidal", c(0.7, 0.8, 0.9, 1))) %>% 
    multiple.bias(., bias_function = "probsens.conf",
                  prev.exp = list("beta", c(24.9, 58.1)),
                  prev.nexp = list("beta", c(42.9, 54.6)),
                  risk = list("trapezoidal", c(.2, .58, 1.01, 1.24)))
mod6

## ----plot5, message=FALSE, warning=FALSE,fig.width=6,fig.height=4-------------
plot(mod6, "or")

plot(mod6, "or_tot")

