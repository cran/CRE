#' @title
#' Estimate the Individual Treatment Effect (ITE) using S-Learner
#'
#' @description
#' Estimates the Individual Treatment Effect using S-Learner given a response
#' vector, a treatment vector, a features matrix and estimation model for the
#' outcome.
#'
#' @param y An observed response vector.
#' @param z A treatment vector.
#' @param X A features matrix.
#' @param learner_y An estimation model for the outcome.
#'
#' @return
#' A list of ITE estimates.
#'
#' @keywords internal
#'
estimate_ite_slearner <- function(y, z, X, learner_y = "SL.xgboost") {

  logger::log_trace("learner_y: '{learner_y}' was selected.")

  y_model <- SuperLearner::SuperLearner(Y = y,
                                        X = data.frame(X = X, Z = z),
                                        family = gaussian(),
                                        SL.library = learner_y,
                                        cvControl = list(V = 0))

  if (sum(y_model$coef) == 0) y_model$coef[1] <- 1

  y_0_hat <- predict(y_model,
                     data.frame(X = X, Z = rep(0, nrow(X))),
                     onlySL = TRUE)$pred

  y_1_hat <- predict(y_model,
                     data.frame(X = X, Z = rep(1, nrow(X))),
                     onlySL = TRUE)$pred

  ite <- as.vector(y_1_hat - y_0_hat)

  return(ite)
}
