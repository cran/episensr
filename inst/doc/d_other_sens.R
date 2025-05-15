## ----include=FALSE, message=FALSE, warning=FALSE------------------------------
library(episensr)

## ----conf_array---------------------------------------------------------------
confounders.array(crude_risk = 2,
				  type = "binary",
				  bias_parms = c(2.5, 0.1, 0.5))

## ----conf_array_apply,warning=FALSE,message=FALSE,fig.width=6,fig.height=4----
dat <- expand.grid(RR_CD = seq(1, 5.5, 0.5), P_C1 = seq(0, 1, 0.1))
dat$RR_adj <- apply(dat, 1,
					function(x) confounders.array(2,
												  type = "binary",
												  bias_parms = c(x[1],
																 x[2],
																 0.5))[[3]][1])

## ----array_3d,warning=FALSE,message=FALSE,fig.width=8,fig.height=8------------
library(lattice)
library(grid)
wireframe(RR_adj ~ RR_CD * P_C1,
		  data = dat,
		  xlab = "RR\nconfounder-outcome",
		  ylab = "Prevalence confounder\namong exposed",
		  zlab = "Adjusted\nRR",
		  drape = TRUE, colorkey = TRUE,
		  scales = list(arrows = FALSE, cex = .5, tick.number = 10,
						z = list(arrows = FALSE), distance = c(1.5, 1.5, 1.5)),
		  zlim = 0:4,
		  light.source = c(10, 0, 10),
		  col.regions = rainbow(100, s = 1, v = 1,
								start = 0, end = max(1, 100 - 1) / 100,
								alpha = .8),
		  screen = list(z = -60, x = -60),
		  panel = function(...) {
			  panel.wireframe(...)
			  grid.text("Observed RR = 1\nPrevalence confounder\namong unexposed = 0.5",
						0.125, 0.175, default.units = "native")
		  })

## ----conf_ext-----------------------------------------------------------------
confounders.ext(RR = 1, bias_parms = c(0.1, 1.6, 0.1, 0.51))

## ----conf_ext_apply,warning=FALSE,message=FALSE,fig.width=8,fig.height=6------
dat <- expand.grid(RR_CD = seq(0.1, 1, 0.1))
dat$nsaid <- apply(dat, 1,
				   function(x) confounders.ext(1,
											   bias_parms = c(x[1], 0.9,
															  0.1, 0.4))[[3]][2])
dat$non_user <- apply(dat, 1,
					  function(x) confounders.ext(1,
												  bias_parms = c(x[1], 1.03,
																 0.09, 0.12))[[3]][2])
dat$naproxen <- apply(dat, 1,
					  function(x) confounders.ext(1,
												  bias_parms = c(x[1], 1.15,
																 0.09, 0.79))[[3]][2])
dat$rof_napro <- apply(dat, 1,
					   function(x) confounders.ext(1,
												   bias_parms = c(x[1], 1.6,
																  0.1, 0.51))[[3]][2])
library(tidyr)
dat2 <- dat %>% gather(nsaid, non_user, naproxen, rof_napro,
					   key = "COX2", value = "bias_perc")

ggplot(dat2, aes(x = RR_CD, y = bias_perc, group = COX2, colour = COX2)) +
	geom_line() +
	scale_colour_brewer(palette = "Dark2",
						labels = c("COX-2 vs. naproxen", "COX-2 vs. non-users",
								   "COX-2 vs. non-selective NSAIDs",
								   "Rofecoxib vs. naproxen")) +
	geom_vline(xintercept = 0.7) +
	xlab("Association Confounder-Disease (RR)") +
	ylab("Bias of Exposure-Disease Association (RR) in %") +
	ggtitle(expression(paste("Bias as a function of misspecification of the ",
							 RR[CD], " from the literature"))) +
	theme(legend.position = c(.85, .3),
		  legend.title = element_blank()) +
	annotate("text", label = 'paste("Literature estimate ", RR[CD], " = 0.7")',
			 x = 0.6, y = -3.75, parse = TRUE)

## ----e-value-1----------------------------------------------------------------
confounders.evalue(est = 3.9, lower_ci = 1.8, upper_ci = 8.7, type = "RR")

## ----e-value-2----------------------------------------------------------------
confounders.evalue(est = 1.06, lower_ci = 0.93, upper_ci = 1.22,
				   type = "RR", true_est = 1.2)

