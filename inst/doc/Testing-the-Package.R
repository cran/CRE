## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- warning=FALSE, eval=FALSE-----------------------------------------------
#  library(CRE)
#  
#  # Generate sample data
#  set.seed(1358)
#  dataset <- generate_cre_dataset(n = 1000,
#                                  rho = 0,
#                                  n_rules = 2,
#                                  p = 10,
#                                  effect_size = 2,
#                                  binary_covariates = TRUE,
#                                  binary_outcome = FALSE,
#                                  confounding = "no")
#  y <- dataset[["y"]]
#  z <- dataset[["z"]]
#  X <- dataset[["X"]]
#  
#  method_params <- list(ratio_dis = 0.5,
#                        ite_method = "aipw",
#                        learner_ps = "SL.xgboost",
#                        learner_y = "SL.xgboost",
#                        offset = NULL)
#  
#  hyper_params <- list(intervention_vars = NULL,
#                       ntrees = 20,
#                       node_size = 20,
#                       max_rules = 50,
#                       max_depth = 3,
#                       t_decay = 0.025,
#                       t_ext = 0.01,
#                       t_corr = 1,
#                       t_pvalue = 0.05,
#                       stability_selection = "vanilla",
#                       cutoff = 0.6,
#                       pfer = 1,
#                       B = 10,
#                       subsample = 0.5)
#  
#  # linreg CATE estimation with aipw ITE estimation
#  cre_results <- cre(y, z, X, method_params, hyper_params)
#  summary(cre_results)
#  plot(cre_results)
#  ite_pred <- predict(cre_results, X)

