## ----probsens-----------------------------------------------------------------
library(episensr)
set.seed(123)
smoke.nd <- probsens(matrix(c(215, 1449, 668, 4296),
                            dimnames = list(c("BC+", "BC-"), c("Smoke+", "Smoke-")),
                            nrow = 2, byrow = TRUE),
                     type = "exposure",
                     reps = 50000,
                     seca.parms = list("uniform", c(.7, .95)),
                     spca.parms = list("uniform", c(.9, .99)))
smoke.nd

## ----str----------------------------------------------------------------------
str(smoke.nd)

## ----plot, fig.cap = "Sensibility prior distribution.",fig.width=6,fig.height=4----
plot(smoke.nd, "seca")

## ---- fig.cap='Log-normal distribution with meanlog = 2.159 and sdlog = 0.28.',fig.width=6,fig.height=4----
set.seed(123)
x <- rlnorm(10000, meanlog = 2.159, sdlog = 0.28)
quantile(x, c(0.025, 0.975))
plot(density(x))

## ----probsens-conf------------------------------------------------------------
set.seed(123)
greenland <- probsens.conf(matrix(c(45, 94, 257, 945),
                                  dimnames = list(c("Cases+", "Cases-"), c("Res+", "Res-")),
                                  nrow = 2, byrow = TRUE),
                           reps = 50000,
                           prev.exp = list("uniform", c(.4, .7)),
                           prev.nexp = list("uniform", c(.4, .7)),
                           risk = list("log-normal", c(2.159, .28)))
greenland

## ----probsens_conf_plot, fig.cap='Distribution of the 50,000 confounder-adjusted odds ratios.',fig.width=6,fig.height=4----
plot(greenland, "or_tot")

