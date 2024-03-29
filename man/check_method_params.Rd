% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_method_params.R
\name{check_method_params}
\alias{check_method_params}
\title{Check method-related parameters}
\usage{
check_method_params(y, ite, params)
}
\arguments{
\item{y}{The observed response vector.}

\item{ite}{The estimated ITE vector.}

\item{params}{The list of parameters required to run the method functions.}
}
\value{
A modified input \code{params}. A list of parameters that might be changed during
the checks.
}
\description{
Checks method-related parameters.
}
\keyword{internal}
