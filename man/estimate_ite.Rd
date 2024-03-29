% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_ite.R
\name{estimate_ite}
\alias{estimate_ite}
\title{Estimate the Individual Treatment Effect (ITE)}
\usage{
estimate_ite(y, z, X, ite_method, ...)
}
\arguments{
\item{y}{An observed response vector.}

\item{z}{An observed treatment vector.}

\item{X}{A covariate matrix.}

\item{ite_method}{A method for estimating the Individual Treatment Effect.
Some methods requires additional parameters. These parameters are mentioned
in the indented blocks for each method and their definitions are provided at
the end of this parameters list.
\itemize{
\item \code{"slearner"}: S-Learner.
- \code{learner_y}
\item \code{"tlearner"}: T-Learner.
\itemize{
\item \code{learner_y}
}
\item \code{"tpoisson"}: T-Poisson.
\itemize{
\item \code{offset}
}
\item \code{"xlearner"}: X-Learner.
\itemize{
\item \code{learner_y}
}
\item \code{"aipw"}: Augmented Inverse Probability Weighting.
\itemize{
\item \code{learner_ps} and  \code{learner_y}
}
\item \code{"bart"}: Bayesian Additive Regression Trees.
\itemize{
\item \code{learner_ps}
}
\item \code{"cf"}: Causal Forest.
\itemize{
\item \code{learner_ps}
}
}}

\item{...}{Additional parameters passed to different models.}
}
\value{
A list of ITE estimates.
}
\description{
Estimates the Individual Treatment Effect given a response vector,
a treatment vector, a covariate matrix, and a desired algorithm.
}
\details{
\subsection{Additional parameters}{
\itemize{
\item \strong{learner_ps}: An estimation method for the propensity score. This
includes libraries for the SuperLearner package.
\item \strong{learner_y}: An estimation model for the outcome. This includes
libraries for the SuperLearner package.
\item \strong{offset}: Name of the covariate to use as offset (i.e. \code{"x1"}) for
Poisson ITE Estimation. \code{NULL} if offset is not used.
}
}
}
\keyword{internal}
