test_that("cre Runs Correctly", {
  # Generate sample data
  set.seed(2021)
  dataset_cont <- generate_cre_dataset(n = 300, rho = 0, n_rules = 2, p = 10,
                                       effect_size = 2, binary = FALSE)
  y <- dataset_cont[["y"]]
  z <- dataset_cont[["z"]]
  X <- as.data.frame(dataset_cont[["X"]])
  X_names <- names(as.data.frame(X))

  method_params = list(ratio_dis = 0.25,
                       ite_method_dis="bart",
                       ps_method_dis = "SL.xgboost",
                       oreg_method_dis = "SL.xgboost",
                       include_ps_dis = TRUE,
                       ite_method_inf = "bart",
                       ps_method_inf = "SL.xgboost",
                       oreg_method_inf = "SL.xgboost",
                       include_ps_inf = TRUE,
                       include_offset = FALSE,
                       cate_method = "DRLearner",
                       cate_SL_library = "SL.xgboost",
                       filter_cate = FALSE,
                       offset_name = NA,
                       random_state = 3591)

 hyper_params = list(ntrees_rf = 100,
                     ntrees_gbm = 50,
                     node_size = 20,
                     max_nodes = 5,
                     max_depth = 15,
                     max_decay = 0.025,
                     type_decay = 2,
                     t_anom = 0.025,
                     t_corr = 1,
                     replace = FALSE,
                     q = 0.8,
                     stability_selection = TRUE,
                     pfer_val = 0.1)

  method_params[["ratio_dis"]] <- 2
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ratio_dis"]] <- 0.25
  method_params[["ite_method_dis"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_dis"]] <- "bart"
  method_params[["ite_method_inf"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_inf"]] <- "bart"
  method_params[["include_ps_dis"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["include_ps_dis"]] <- TRUE
  method_params[["include_ps_inf"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["include_ps_inf"]] <- TRUE
  method_params[["ite_method_dis"]] <- "poisson"
  method_params[["ps_method_dis"]] <- 1
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_dis"]] <- "bart"
  method_params[["ps_method_dis"]] <- "SL.xgboost"
  method_params[["ite_method_inf"]] <- "poisson"
  method_params[["ps_method_inf"]] <- 1
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_inf"]] <- "bart"
  method_params[["ps_method_inf"]] <- "SL.xgboost"
  method_params[["ite_method_dis"]] <- "aipw"
  method_params[["oreg_method_dis"]] <- 1
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_dis"]] <- "bart"
  method_params[["oreg_method_dis"]] <- "SL.xgboost"
  method_params[["ite_method_inf"]] <- "aipw"
  method_params[["oreg_method_inf"]] <- 1
  expect_error(cre(y, z, X, method_params, hyper_params))

  method_params[["ite_method_inf"]] <- "bart"
  method_params[["oreg_method_inf"]] <- "SL.xgboost"
  method_params[["ite_method_dis"]] <- "bcf"
  y_temp <- ifelse(y>0,1,0)
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["ite_method_dis"]] <- "poisson"
  method_params[["include_offset"]] <- TRUE
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["include_offset"]] <- FALSE
  method_params[["cate_method"]] <- "test"
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["ite_method_dis"]] <- "bart"
  method_params[["cate_SL_library"]] <- 1
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["cate_SL_library"]] <- "SL.xgboost"
  method_params[["cate_method"]] <- "bart-baggr"
  method_params[["ite_method_inf"]] <- "aipw"
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["cate_method"]] <- "cf-means"
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["cate_method"]] <- "DRLearner"
  method_params[["ite_method_inf"]] <- "bart"
  method_params[["filter_cate"]] <- "test"
  expect_error(cre(y_temp, z, X, method_params, hyper_params))

  method_params[["filter_cate"]] <- FALSE
  hyper_params[["ntrees_rf"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["ntrees_rf"]] <- 100
  hyper_params[["ntrees_gbm"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["ntrees_gbm"]] <- 50
  hyper_params[["node_size"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["node_size"]] <- 5
  hyper_params[["replace"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["replace"]] <- TRUE
  hyper_params[["max_nodes"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["max_nodes"]] <- 5
  hyper_params[["t_anom"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["t_anom"]] <- 0.025
  hyper_params[["t_corr"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["t_corr"]] <- 1
  hyper_params[["q"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["q"]] <- 0.8
  hyper_params[["stability_selection"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  hyper_params[["stability_selection"]] <- TRUE
  hyper_params[["pfer_val"]] <- "test"
  expect_error(cre(y, z, X, method_params, hyper_params))

  # Correct outputs
  hyper_params[["pfer_val"]] <- 0.1
  cre_results <- cre(y, z, X, method_params, hyper_params)
  expect_true(class(cre_results) == "cre")

  hyper_params[["stability_selection"]] <- FALSE
  cre_results <- cre(y, z, X, method_params, hyper_params)
  expect_true(class(cre_results) == "cre")

  method_params[["ite_method_dis"]] <- "aipw"
  method_params[["ite_method_inf"]] <- "aipw"
  cre_results <- cre(y, z, X, method_params, hyper_params)
  expect_true(class(cre_results) == "cre")
})
