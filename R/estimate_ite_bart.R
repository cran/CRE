#' @title
#' Estimate the Individual Treatment Effect using Bayesian Additive Regression Trees
#'
#' @description
#' Estimates the Individual Treatment Effect using Bayesian Additive Regression
#' Trees given a response vector, a treatment vector, and a features matrix.
#'
#' @param y the observed response vector
#' @param z the treatment vector
#' @param X the features matrix
#' @param include_ps whether or not to include propensity score estimate as a
#' covariate in ITE estimation
#' @param ps_method method for the estimation of the propensity score
#' @param random_state An integer value for random state.
#'
#' @return a list of ITE estimates and standard deviations for the ITE estimates
#'
#' @keywords internal
#'
estimate_ite_bart <- function(y, z, X, include_ps, ps_method, random_state) {

  # generate seed value
  set.seed(random_state + 2560)
  seed_vals <- sample(100000, 2)


  if (include_ps) {
    set.seed(seed_vals[1])
    est_ps <- estimate_ps(z, X, ps_method)
    X <- cbind(X, est_ps)
  }


  bart_fit <- bartCause::bartc(as.matrix(y), as.matrix(z), as.matrix(X),
                               n.samples = 500, n.burn = 500,
                               seed = seed_vals[2])

  pd_ite <- bartCause::extract(bart_fit, type = "ite")
  ite <- apply(pd_ite, 2, mean)
  sd_ite <- apply(pd_ite, 2, stats::sd)
  return(list(ite, sd_ite))
}
