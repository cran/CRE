#' @title
#' Discover rules
#'
#' @description
#' Discover the minimal set of rules linearly decomposing the Conditional
#' Average Treatment Effect (CATE).
#'
#' @param X A covariate matrix.
#' @param ite An estimated ITE.
#' @param method_params A vector of method parameters.
#' @param hyper_params A vector of hyper parameters.
#'
#' @return
#' A minimal set of rules linearly decomposing the Conditional Average
#' Treatment Effect (CATE).
#'
#' @keywords internal
#'
discover_rules <- function(X, ite, method_params, hyper_params) {

  # Generate rules -------------------------------------------------------------
  rules <- generate_rules(X,
                          ite,
                          getElement(hyper_params, "ntrees"),
                          getElement(hyper_params, "node_size"),
                          getElement(hyper_params, "max_rules"),
                          getElement(hyper_params, "max_depth"))
  M_initial <- length(rules)
  # Filtering ------------------------------------------------------------------

  # Discard irrelevant variable-value pair from a rule condition ---------------
  rules <- filter_irrelevant_rules(rules, X, ite,
                                        getElement(hyper_params, "t_decay"))
  M_filter1 <- length(rules)
  # Generate rules matrix ------------------------------------------------------
  rules_matrix <- generate_rules_matrix(X, rules)

  # Discard rules with too few or too many observations rules ------------------
  rules_matrix <- filter_extreme_rules(rules_matrix, rules,
                                       getElement(hyper_params, "t_ext"))
  rules <- colnames(rules_matrix)
  M_filter2 <- length(rules)

  # Discard correlated rules ---------------------------------------------------
  rules_matrix <- filter_correlated_rules(rules_matrix, rules,
                                           getElement(hyper_params, "t_corr"))
  rules <- colnames(rules_matrix)
  M_filter3 <- length(rules)

  # Select Rules ---------------------------------------------------------------
  rules <- select_rules(rules_matrix,
                        rules,
                        ite,
                        getElement(hyper_params, "stability_selection"),
                        getElement(hyper_params, "cutoff"),
                        getElement(hyper_params, "pfer"),
                        getElement(hyper_params, "B"))
  rules <- as.character(rules)
  M_select1 <- length(rules)

  M <- list("initial" = M_initial,
            "filter_irrelevant" = M_filter1,
            "filter_extreme" = M_filter2,
            "filter_correlated" = M_filter3,
            "select_LASSO" = M_select1)

  return(list(rules = rules, M = M))
}
