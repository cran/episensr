% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misclassification.cov.R
\name{misclassification.cov}
\alias{misclassification.cov}
\title{Sensitivity analysis for covariate misclassification.}
\usage{
misclassification.cov(
  case,
  exposed,
  covariate,
  bias_parms = NULL,
  alpha = 0.05
)
}
\arguments{
\item{case}{Outcome variable. If a variable, this variable is tabulated against.}

\item{exposed}{Exposure variable.}

\item{covariate}{Covariate to stratify on.}

\item{bias_parms}{Vector defining the bias parameters. This vector has 4 elements
between 0 and 1, in the following order:
\enumerate{
\item Sensitivity of confounder classification among those with the outcome,
\item Sensitivity of confounder classification among those without the outcome,
\item Specificity of confounder classification among those with the outcome,and
\item Specificity of confounder classification among those without the outcome.
}}

\item{alpha}{Significance level.}
}
\value{
A list with elements:
\item{obs.data}{The analyzed stratified 2 x 2 tables from the observed data.}
\item{corr.data}{The expected stratified observed data given the true data assuming
misclassification.}
\item{obs.measures}{A table of observed relative risk and odds ratio with
confidence intervals.}
\item{adj.measures}{A table of adjusted relative risk and odds ratio.}
\item{bias.parms}{Input bias parameters.}
}
\description{
Simple sensitivity analysis to correct for a misclassified covariate (a potential
confounder or effect measure modifier).
}
\examples{
# The data for this example come from:
# Berry, R.J., Kihlberg, R., and Devine, O. Impact of misclassification of in vitro
# fertilisation in studies of folic acid and twinning: modelling using population
# based Swedish vital records.
# BMJ, doi:10.1136/bmj.38369.437789.82 (published 17 March 2004)
misclassification.cov(array(c(1319, 38054, 5641, 405546,
565, 3583, 781, 21958,
754, 34471, 4860, 383588),
dimnames = list(c("Twins+", "Twins-"),
c("Folic acid+", "Folic acid-"), c("Total", "IVF+", "IVF-")),
dim = c(2, 2, 3)),
bias_parms = c(.6, .6, .95, .95))
}
\references{
Lash, T.L., Fox, M.P, Fink, A.K., 2009 \emph{Applying Quantitative
Bias Analysis to Epidemiologic Data}, pp.79--108, Springer.
}
