% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_ite_aipw.R
\name{estimate_ite_aipw}
\alias{estimate_ite_aipw}
\title{Estimate the Individual Treatment Effect using Augmented Inverse Propensity
Weighting}
\usage{
estimate_ite_aipw(
  y,
  z,
  X,
  ps_method = "SL.xgboost",
  oreg_method = "SL.xgboost"
)
}
\arguments{
\item{y}{the observed response vector}

\item{z}{the treatment vector}

\item{X}{the features matrix}

\item{ps_method}{the estimation model for the propensity score}

\item{oreg_method}{the estimation model for the outcome regressions}
}
\value{
a list of ITE estimates and standard deviations for the ITE estimates
}
\description{
Estimates the Individual Treatment Effect using Augmented Inverse Propensity
Weighting given a response vector, a treatment vector, a features matrix,
an estimation model for the propensity score and estimation model for the
outcome regressions
}
\keyword{internal}
