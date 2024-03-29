% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.R
\name{predict.cre}
\alias{predict.cre}
\title{Predict individual treatment effect via causal rule ensemble}
\usage{
\method{predict}{cre}(object, X, ...)
}
\arguments{
\item{object}{A \code{cre} object from running the CRE function.}

\item{X}{A covariate matrix (or data.frame)}

\item{...}{Additional arguments passed to customize the prediction.}
}
\value{
An array with the estimated Individual Treatment Effects
}
\description{
Predicts individual treatment effect via causal rule ensemble algorithm.
}
