#' @title
#' Prune (Causal) Decision Rules
#'
#' @description
#' Method for pruning (Causal) Decision Rules extracted from the Random Forest or
#' Gradient Boosting algorithms.
#'
#' @param rules A list of decision rules.
#' @param X The features matrix.
#' @param ite_std The standardized ITE.
#' @param max_decay Decay Threshold for pruning the rules.
#' @param type_decay Decay Type for pruning the rules (1: relative error; 2: error).
#'
#' @keywords internal
#'
#' @return
#' A list of (Causal) Decision Rules.
#'
prune_rules <- function(rules, X, ite_std, max_decay, type_decay){

  rules_matrix <- matrix(rules)
  colnames(rules_matrix) <- "condition"
  metric <- inTrees::getRuleMetric(rules_matrix,
                                   X,
                                   ite_std)

  pruned <- inTrees::pruneRule(rules = metric,
                               X = X,
                               target = ite_std,
                               maxDecay = max_decay,
                               typeDecay = type_decay)
  rules <- unique(pruned[, 4])
  return(rules)
}
