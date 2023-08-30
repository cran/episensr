## ----selection----------------------------------------------------------------
library(episensr)

stang <- selection(matrix(c(136, 107, 297, 165),
                          dimnames = list(c("UM+", "UM-"), c("Mobile+", "Mobile-")),
                          nrow = 2, byrow = TRUE),
                   bias_parms = c(.94, .85, .64, .25))
stang

## ----misclass-----------------------------------------------------------------
misclassification(matrix(c(126, 92, 71, 224),
                         dimnames = list(c("Case", "Control"),
                                         c("Smoking +", "Smoking - ")),
                         nrow = 2, byrow = TRUE),
                  type = "exposure",
                  bias_parms = c(0.94, 0.94, 0.97, 0.97))

## ---- warning=FALSE,fig.cap='Contour plot of point estimates of corrected odds ratio (OR)',fig.width=6,fig.height=4----
dat <- expand.grid(Se = seq(0.582, 1, 0.02),
                   Sp = seq(0.762, 1, 0.02))

dat$OR_c <- apply(dat, 1,
                  function(x) misclassification(matrix(c(126, 92, 71, 224),
                                                       nrow = 2, byrow = TRUE),
                                                type = "exposure",
                                                bias_parms = c(x[1], x[1], x[2], x[2]))$adj.measures[2, 1])
dat$OR_c <- round(dat$OR_c, 2)

library(ggplot2)
library(directlabels)
p1 <- ggplot(dat, aes(x = Se, y = Sp, z = OR_c)) +
    geom_contour(aes(colour = ..level..), breaks = c(4.32, 6.96, 8.56, 12.79, 23.41, 432.1)) +
    annotate("text", x = 1, y = 1, label = "4.32", size = 3) +
    scale_fill_gradient(limits = range(dat$OR_c), high = 'red', low = 'green') +
    scale_x_continuous(breaks = seq(0.5, 1, .1), expand = c(0,0)) +
    scale_y_continuous(breaks = seq(0.5, 1, .1), expand = c(0,0)) +
    coord_fixed(ylim = c(0.5, 1.025), xlim = c(0.5, 1.025)) +
    scale_colour_gradient(guide = 'none') +
    xlab("Sensitivity") +
    ylab("Specificity") +
    ggtitle("Estimates of Corrected OR")
direct.label(p1, list("far.from.others.borders", "calc.boxes", "enlarge.box",
                      hjust = 1, vjust = -.5, box.color = NA, cex = .6,
                      fill = "transparent", "draw.rects"))

## ---- warning=FALSE,fig.cap='Contour plot of 95% lower confidence limit of corrected OR',warning=FALSE,fig.width=6,fig.height=4----
dat$ORc_lci <- apply(dat, 1,
                     function(x) misclassification(matrix(c(126, 92, 71, 224),
                                                          nrow = 2, byrow = TRUE),
                                                   type = "exposure",
                                                   bias_parms = c(x[1], x[1], x[2], x[2]))$adj.measures[2, 2])
dat$ORc_lci <- round(dat$ORc_lci, 2)

p3 <- ggplot(dat, aes(x = Se, y = Sp, z = ORc_lci)) +
    geom_contour(aes(colour = ..level..),
                 breaks = c(4.05, 4.64, 5.68, 7.00, 9.60)) +
    annotate("text", x = 1, y = 1, label = "2.96", size = 3) +
    scale_fill_gradient(limits = range(dat$ORc_lci), high = 'red', low = 'green') +
    scale_x_continuous(breaks = seq(0.5, 1, .1), expand = c(0,0)) +
    scale_y_continuous(breaks = seq(0.5, 1, .1), expand = c(0,0)) +
    coord_fixed(ylim = c(0.5, 1.025), xlim = c(0.5, 1.025)) +
    scale_colour_gradient(guide = 'none') +
    xlab("Sensitivity") +
    ylab("Specificity") +
    ggtitle("95% LCI of Corrected OR")
direct.label(p3, list("far.from.others.borders", "calc.boxes", "enlarge.box",
                           hjust = 1, vjust = -.5, box.color = NA, cex = .6,
                           fill = "transparent", "draw.rects"))

## ---- misclass_pv-------------------------------------------------------------
misclassification(matrix(c(599, 4978, 31175, 391851),
                         dimnames = list(c("Preterm", "Term"), c("Underweight", "Normal weight")),
                         nrow = 2, byrow = TRUE),
                  type = "exposure_pv",
                  bias_parms = c(0.65, 0.74, 1, 0.98))

## ----cov_misclass-------------------------------------------------------------
misclassification.cov(array(c(1319, 38054, 5641, 405546, 565, 3583,
                              781, 21958, 754, 34471, 4860, 383588),
                            dimnames = list(c("Twins+", "Twins-"),
                                            c("Folic acid+", "Folic acid-"),
                                            c("Total", "IVF+", "IVF-")),
                            dim = c(2, 2, 3)),
                      bias_parms = c(.6, .6, .95, .95))

## ----confounders--------------------------------------------------------------
tyndall <- confounders(matrix(c(105, 85, 527, 93),
                              dimnames = list(c("HIV+", "HIV-"), c("Circ+", "Circ-")),
                              nrow = 2, byrow = TRUE),
                       type = "RR",
                       bias_parms = c(.63, .8, .05))
tyndall

## ----confounders_add----------------------------------------------------------
## Confounder +
tyndall$cfder.data

## Confounder -
tyndall$nocfder.data

## ----miettinen1---------------------------------------------------------------
rash <- matrix(c(15, 94, 52, 1163),
               dimnames = list(c("Rash +", "Rash -"),
                               c("Allopurinol +", "Allopurinol -")),
               nrow = 2, byrow = TRUE)

## ----miettinen1-tab, echo=FALSE-----------------------------------------------
knitr::kable(rash)

## ----miettinen1-conf----------------------------------------------------------
## Outcome by confounders
rash_conf <- matrix(c(36, 58, 645, 518),
                    dimnames = list(c("Rash +", "Rash -"),
                                    c("Males", "Females")),
                    nrow = 2, byrow = TRUE)
## By confounders: among males
rash_males <- matrix(c(5, 36, 33, 645),
                     dimnames = list(c("Rash +", "Rash -"),
                                     c("Allopurinol +", "Allopurinol -")),
                     nrow = 2, byrow = TRUE)
## By confounders: among females
rash_females <- matrix(c(10, 58, 19, 518),
                       dimnames = list(c("Rash +", "Rash -"),
                                       c("Allopurinol +", "Allopurinol -")),
                       nrow = 2, byrow = TRUE)

## ----miettinen1-conftab, echo=FALSE-------------------------------------------
knitr::kable(rash_conf, caption = "Outcome by confounders")
knitr::kable(rash_males, caption = "Among males")
knitr::kable(rash_females, caption = "Among females")

## ----miettinen1_parms---------------------------------------------------------
(RR_no <- (36/(36+645))/(58/(58+518))) # RR between confounder and outcome among non-exposed
(p1 <- (5+33)/(15+52)) # prevalence of confounder among exposed
(p2 <- (36+645)/(94+1163)) # prevalence of confounder among unexposed

## ----miettinen1_res-----------------------------------------------------------
rash %>% confounders(., type = "RR", bias_parms = c(RR_no, p1, p2))

## ----miettinen2---------------------------------------------------------------
thromb <- matrix(c(12, 30, 53, 347),
                 dimnames = list(c("Thrombosis +", "Thrombosis -"),
                                 c("OC +", "OC -")),
                 nrow = 2, byrow = TRUE)

## ----miettinen2-tab, echo=FALSE-----------------------------------------------
knitr::kable(thromb)

## ----miettinen2-conf----------------------------------------------------------
## Outcome by confounders
thromb_conf <- matrix(c(18, 12, 158, 189),
                      dimnames = list(c("Thrombosis +", "Thrombosis -"),
                                      c("20-29 years old", "30-39 years old")),
                      nrow = 2, byrow = TRUE)
## By confounders: among 20-29 years old
thromb_younger <- matrix(c(10, 18, 39, 158),
                       dimnames = list(c("Thrombosis +", "Thrombosis -"),
                                       c("OC +", "OC -")),
                       nrow = 2, byrow = TRUE)
## By confounders: among 30-39 years old
thromb_older <- matrix(c(2, 12, 14, 189),
                     dimnames = list(c("Thrombosis +", "Thrombosis -"),
                                     c("OC +", "OC -")),
                     nrow = 2, byrow = TRUE)

## ----miettinen2-conftab, echo=FALSE-------------------------------------------
knitr::kable(thromb_conf, caption = "Outcome by confounders")
knitr::kable(thromb_younger, caption = "Among 20-29 years old")
knitr::kable(thromb_older, caption = "Among 30-39 years old")

## ----miettinen2_parms---------------------------------------------------------
(OR_no <- (18/12)/(158/189)) # OR between confounder and outcome among non-exposed
(p1 <- (10+39)/(12+53)) # prevalence of confounder among exposed
(p2 <- (18+158)/(30+347)) # prevalence of confounder among unexposed

## ----miettinen2_res-----------------------------------------------------------
thromb %>% confounders(., type = "OR", bias_parms = c(OR_no, p1, p2))

## ---- boot--------------------------------------------------------------------
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

