test_that("CF ITE Estimated Correctly", {

  skip_if_not_installed("grf")

  # Generate sample data
  set.seed(2021)
  dataset_cont <- generate_cre_dataset(n = 100, rho = 0, n_rules = 2, p = 10,
                                       effect_size = 0.5, binary = FALSE)
  y <- dataset_cont[["y"]]
  z <- dataset_cont[["z"]]
  X <- dataset_cont[["X"]]
  include_ps <- TRUE
  ps_method <- "SL.xgboost"

  # Incorrect data inputs
  expect_error(estimate_ite_cf(y = "test", z, X, include_ps, ps_method))
  expect_error(estimate_ite_cf(y, z = "test", X, include_ps, ps_method))
  expect_error(estimate_ite_cf(y, z, X = NA, include_ps, ps_method))
  expect_error(estimate_ite_cf(y, z, X = NA, include_ps = "test", ps_method))
  expect_error(estimate_ite_cf(y, z, X = NA, include_ps = NA, ps_method))

  # Correct outputs
  ite_result <- estimate_ite_cf(y, z, X, include_ps, ps_method)
  expect_true(length(ite_result) == 2)
  expect_true(length(ite_result[[1]]) == length(y))
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(length(ite_result[[2]]) == length(y))
  expect_true(class(ite_result[[2]]) == "numeric")
})
