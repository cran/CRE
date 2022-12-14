test_that("ITE Estimated Correctly", {

  #Generate sample data
  set.seed(181)
  dts_1 <- generate_cre_dataset(n = 300, rho = 0, n_rules = 2, p = 10,
                                       effect_size = 2, binary = FALSE)
  dts_2 <- generate_cre_dataset(n = 100, rho = 0, n_rules = 2, p = 10,
                                    effect_size = 2, binary = FALSE)

  ite_method <- "bart"
  include_ps <- TRUE
  ps_method <- "SL.xgboost"
  oreg_method <- NA
  ntrees <- 100
  node_size <- 20
  max_nodes <- 5
  random_state <- 121

  # Check for binary outcome
  binary <- ifelse(length(unique(dts_1$y)) == 2, TRUE, FALSE)

  # Wrong ite estimator
  expect_error(estimate_ite(y = dts_2$y, z=dts_1$z, dts_1$X,
                            ite_method = "test", binary,
                            include_ps = include_ps,
                            ps_method = ps_method,
                            oreg_method = oreg_method,
                            random_state = random_state))

  # Missing arguments
  expect_error(estimate_ite(y = dts_2$y, z=dts_1$z, dts_1$X,
                            ite_method = "poisson", binary,
                            include_ps = include_ps,
                            ps_method = ps_method,
                            oreg_method = oreg_method,
                            random_state = random_state))

  # Wrong input size
  expect_error(estimate_ite(y = dts_2$y, z=dts_1$z, dts_1$X,
                              ite_method, binary,
                              include_ps = include_ps,
                              ps_method = ps_method,
                              oreg_method = oreg_method,
                              random_state = random_state))

  expect_warning(expect_error(estimate_ite(y = dts_1$y, z=dts_2$z, dts_1$X,
                              ite_method, binary,
                              include_ps = include_ps,
                              ps_method = ps_method,
                              oreg_method = oreg_method,
                              random_state = random_state)))

  expect_warning(expect_error(estimate_ite(y = dts_1$y, z=dts_1$z, dts_2$X,
                              ite_method, binary,
                              include_ps = include_ps,
                              ps_method = ps_method,
                              oreg_method = oreg_method,
                              random_state = random_state)))

  # wrong input for binary value
  expect_warning(expect_error(estimate_ite(y = dts_1$y, z=dts_1$z, dts_2$X,
                             ite_method, is_y_binary = "TRUE",
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)))


  # Correct outputs
  ite_result <- estimate_ite(y = dts_1$y, z=dts_1$z, dts_1$X,
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))


  ite_method <- "sipw"
  ite_result <- estimate_ite(y = dts_1$y, z=dts_1$z, dts_1$X,
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))


  ite_method <- "bcf"
  ite_result <- estimate_ite(y = dts_1$y, z=dts_1$z, as.matrix(dts_1$X),
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))

  ite_method <- "poisson"
  ite_result <- estimate_ite(y = round(abs(dts_1$y)+1), z=dts_1$z, dts_1$X,
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state,
                             include_offset = FALSE,
                             offset_name = NA,
                             X_names = names(dts_1$X))

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))
})


test_that("ITE (oreg) Estimated Correctly", {

  skip_if_not_installed("BART")
  #Generate sample data
  set.seed(233)
  dts_1 <- generate_cre_dataset(n = 300, rho = 0, n_rules = 2, p = 10,
                                effect_size = 2, binary = FALSE)

  ite_method <- "bart"
  include_ps <- TRUE
  ps_method <- "SL.xgboost"
  oreg_method <- NA
  ntrees <- 100
  node_size <- 20
  max_nodes <- 5
  random_state <- 121

  # Check for binary outcome
  binary <- ifelse(length(unique(dts_1$y)) == 2, TRUE, FALSE)


  ite_method <- "oreg"
  ite_result <- estimate_ite(y = dts_1$y, z=dts_1$z, dts_1$X,
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))
})


test_that("ITE (cf) Estimated Correctly", {

  skip_if_not_installed("grf")

  ite_method <- "cf"
  include_ps <- TRUE
  ps_method <- "SL.xgboost"
  oreg_method <- NA
  ntrees <- 100
  node_size <- 20
  max_nodes <- 5
  random_state <- 121

  dts_1 <- generate_cre_dataset(n = 300, rho = 0, n_rules = 2, p = 10,
                                effect_size = 2, binary = TRUE)
  binary <- ifelse(length(unique(dts_1$y)) == 2, TRUE, FALSE)
  ite_result <- estimate_ite(y = abs(dts_1$y), z=dts_1$z, dts_1$X,
                             ite_method, is_y_binary = binary,
                             include_ps = include_ps,
                             ps_method = ps_method,
                             oreg_method = oreg_method,
                             random_state = random_state)

  expect_true(length(ite_result) == 3)
  expect_true(class(ite_result[[1]]) == "numeric")
  expect_true(class(ite_result[[2]]) == "numeric")
  expect_true(length(ite_result[[1]]) == length(dts_1$y))
  expect_true(length(ite_result[[2]]) == length(dts_1$y))
})
