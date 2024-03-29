#' @title
#' Estimate the Individual Treatment Effect (ITE)
#'
#' @description
#' Estimates the Individual Treatment Effect given a response vector,
#' a treatment vector, a covariate matrix, and a desired algorithm.
#'
#' @param y An observed response vector.
#' @param z An observed treatment vector.
#' @param X A covariate matrix.
#' @param ite_method A method for estimating the Individual Treatment Effect.
#' Some methods requires additional parameters. These parameters are mentioned
#' in the indented blocks for each method and their definitions are provided at
#' the end of this parameters list.
#'   -  \code{"slearner"}: S-Learner.
#'     - `learner_y`
#'   - \code{"tlearner"}: T-Learner.
#'     - `learner_y`
#'   - \code{"tpoisson"}: T-Poisson.
#'     - `offset`
#'   - \code{"xlearner"}: X-Learner.
#'     - `learner_y`
#'   - \code{"aipw"}: Augmented Inverse Probability Weighting.
#'     - `learner_ps` and  `learner_y`
#'   - \code{"bart"}: Bayesian Additive Regression Trees.
#'     - `learner_ps`
#'   - \code{"cf"}: Causal Forest.
#'     - `learner_ps`
#' @param ... Additional parameters passed to different models.
#' @details
#' ## Additional parameters
#'   - **learner_ps**: An estimation method for the propensity score. This
#'   includes libraries for the SuperLearner package.
#'   - **learner_y**: An estimation model for the outcome. This includes
#'   libraries for the SuperLearner package.
#'   - **offset**: Name of the covariate to use as offset (i.e. \code{"x1"}) for
#'     Poisson ITE Estimation. `NULL` if offset is not used.
#'
#' @return
#' A list of ITE estimates.
#'
#' @keywords internal
#'
estimate_ite <- function(y, z, X, ite_method, ...) {

  logger::log_debug("Estimating ITE...")
  st_time <- proc.time()
  # Address visible binding error.
  offset <- learner_y <- learner_ps <- NULL


  ## collect additional arguments
  dot_args <- list(...)
  arg_names <- names(dot_args)

  for (i in arg_names){
    assign(i, unlist(dot_args[i], use.names = FALSE))
  }

  check_args <- function(required_args, arg_names) {
    for (arg in required_args){
      if (!is.element(arg, arg_names)) {
        stop(paste("At least one argument is not provided. Missing argument: ",
                   arg, "."))
      }
    }
  }

  if (ite_method == "slearner") {
    check_args(c("learner_y"), arg_names)
    ite <- estimate_ite_slearner(y, z, X, learner_y)
  } else if (ite_method == "tlearner") {
    check_args(c("learner_y"), arg_names)
    ite <- estimate_ite_tlearner(y, z, X, learner_y)
  } else if (ite_method == "xlearner") {
    check_args(c("learner_y"), arg_names)
    ite <- estimate_ite_xlearner(y, z, X, learner_y)
  }else if (ite_method == "aipw") {
    check_args(c("learner_ps", "learner_y"), arg_names)
    ite <- estimate_ite_aipw(y, z, X, learner_ps, learner_y)
  } else if (ite_method == "bart") {
    check_args(c("learner_ps"), arg_names)
    ite <- estimate_ite_bart(y, z, X, learner_ps)
  } else if (ite_method == "cf") {
    check_args(c("learner_ps"), arg_names)
    ite <- estimate_ite_cf(y, z, X, learner_ps)
  } else if (ite_method == "tpoisson") {
    check_args(c("offset"), arg_names)
    ite <- estimate_ite_tpoisson(y, z, X, offset)
  } else {
    stop(paste("Invalid ITE method. Please choose from the following:\n",
               "'slearner', 'tlearner', 'xlearner', 'aipw', 'bart', ",
               "'cf' or 'tpoisson'"))
  }

  en_time <- proc.time()
  logger::log_debug("Done with estimating ITE. ",
                    "(WC: {g_wc_str(st_time, en_time)}", ".)")

  return(ite)
}
