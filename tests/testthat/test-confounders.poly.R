context("check bias due to multi-level confounders")

test_that("correct number of arguments for bias parameters", {
    expect_that(confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                            type = "RR",
                            bias_parms = c(.4, .8, .8)),
                throws_error())
})

test_that("confounder prevalences between 0 and 1", {
    expect_that(confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                            type = "RR",
                            bias_parms = c(.4, .8, -1, 2, .2, .2)),
                throws_error())
})

test_that("RR is correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "RR",
                         bias_parms = c(.4, .8, .6, .05, .2, .2))
    expect_equal(model$obs_measures[1, 1], 0.3479, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 2], 0.2757, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 3], 0.4390, tolerance = 1e-4, scale = 1)
})

test_that("Adjusted RR are correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "RR",
                         bias_parms = c(.4, .8, .6, .05, .2, .2))
    expect_equal(model$adj_measures[1, 1], 0.5393, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[1, 2], 0.6452, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[2, 1], 0.5393, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[2, 2], 0.6452, tolerance = 1e-4, scale = 1)
})

test_that("OR is correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "OR",
                         bias_parms = c(.4, .8, .6, .05, .2, .2))
    expect_equal(model$obs_measures[1, 1], 0.2180, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 2], 0.1519, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 3], 0.3128, tolerance = 1e-4, scale = 1)
})

test_that("Adjusted OR are correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "OR",
                         bias_parms = c(.4, .8, .6, .05, .2, .2))
    expect_equal(model$adj_measures[1, 1], 0.3379, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[1, 2], 0.6452, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[2, 1], 0.3379, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[2, 2], 0.6452, tolerance = 1e-4, scale = 1)
})

test_that("RD is correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "RD",
                         bias_parms = c(-.4, -.2, .6, .05, .2, .2))
    expect_equal(model$obs_measures[1, 1], -0.3114, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 2], -0.3903, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs_measures[1, 3], -0.2325, tolerance = 1e-4, scale = 1)
})

test_that("Adjusted RD are correct", {
    model <- confounders.poly(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                         type = "RD",
                         bias_parms = c(-.4, -.2, .6, .05, .2, .2))
    expect_equal(model$adj_measures[1, 1], -0.0914, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj_measures[1, 2], -0.22, tolerance = 1e-4, scale = 1)
})
