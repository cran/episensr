## ----selection-----------------------------------------------------------
library(episensr)

stang <- selection(matrix(c(136, 107, 297, 165),
                          dimnames = list(c("UM+", "UM-"), c("Mobile+", "Mobile-")),
                          nrow = 2, byrow = TRUE),
                   bias_parms = c(.94, .85, .64, .25))
stang

## ----confounders---------------------------------------------------------
confounders(matrix(c(105, 85, 527, 93),
                   dimnames = list(c("HIV+", "HIV-"), c("Circ+", "Circ-")),
                   nrow = 2, byrow = TRUE),
            type = "RR",
            bias_parms = c(.63, .8, .05))

## ----probsens------------------------------------------------------------
set.seed(123)
smoke.nd <- probsens(matrix(c(215, 1449, 668, 4296),
                            dimnames = list(c("BC+", "BC-"), c("Smoke+", "Smoke-")),
                            nrow = 2, byrow = TRUE),
                     type = "exposure",
                     reps = 10000,
                     seca.parms = list("uniform", c(.7, .95)),
                     spca.parms = list("uniform", c(.9, .99)))
smoke.nd

## ----str-----------------------------------------------------------------
str(smoke.nd)

## ----plot, fig.cap = "Sensibility prior distribution."-------------------
hist(smoke.nd$sim.df[!is.na(smoke.nd$sim.df$corr.RR), ]$seca,
     breaks = seq(0.65, 1, 0.01),
     col = "lightgreen",
     main = NULL,
     xlab = "Sensitivity for Cases")

## ---- boot---------------------------------------------------------------
library(aplore3)  # to get ICU data
data(icu)

## First run the model
misclass_eval <- misclassification(icu$sta, icu$inf,
                                   type = "exposure",
                                   bias_parms = c(.75, .85, .9, .95))
misclass_eval

## Then bootstrap it
set.seed(123)
misclass_boot <- boot.bias(misclass_eval, R = 10000)
misclass_boot

## ---- boot_fig, fig.cap = "Bootstrap replicates and confidence interval.", warning=F----
plot(misclass_boot, "rr")

