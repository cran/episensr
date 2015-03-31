context("check probabilistic sensitivity analysis")

test_that("exposure misclassification (ND): observed measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "exposure",
                      reps = 50000,
                      seca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      spca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 1.6470, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 1.1824, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 2.2941, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 1], 1.7603, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 2], 1.2025, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 3], 2.5769, tolerance = 1e-4, scale = 1)
})

test_that("exposure misclassification (ND): adjusted measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "exposure",
                      reps = 50000,
                      seca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      spca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 2.1756, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 1.7378, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 6.3929, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 2.4539, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 1.8722, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 13.2802, tolerance = 1e-4, scale = 1)
})

test_that("exposure misclassification (D): observed measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "exposure",
                      reps = 50000,
                      seca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      seexp.parms = list("trapezoidal", c(.7, .8, .9, .95)),
                      spca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      spexp.parms = list("trapezoidal", c(.7, .8, .9, .95)),
                      corr.se = .8, corr.sp = .8,
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 1.6470, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 1.1824, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 2.2941, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 1], 1.7603, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 2], 1.2025, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 3], 2.5769, tolerance = 1e-4, scale = 1)
})

test_that("exposure misclassification: adjusted measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "exposure",
                      reps = 50000,
                      seca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      seexp.parms = list("trapezoidal", c(.7, .8, .9, .95)),
                      spca.parms = list("trapezoidal", c(.75, .85, .95, 1)),
                      spexp.parms = list("trapezoidal", c(.7, .8, .9, .95)),
                      corr.se = .8, corr.sp = .8,
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 2.9099, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 1.6856, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 10.0550, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 3.5240, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 1.8107, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 47.8042, tolerance = 1e-4, scale = 1)
})

test_that("outcome misclassification (ND): observed measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "outcome",
                      reps = 50000,
                      seca.parms = list("uniform", c(.8, 1)),
                      spca.parms = list("uniform", c(.8, 1)),
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 1.6470, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 1.1824, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 2.2941, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 1], 1.7603, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 2], 1.2025, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 3], 2.5769, tolerance = 1e-4, scale = 1)
})

test_that("outcome misclassification (ND): adjusted measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "outcome",
                      reps = 50000,
                      seca.parms = list("uniform", c(.8, 1)),
                      spca.parms = list("uniform", c(.8, 1)),
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 2.2803, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 1.6629, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 20.5547, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 2.4596, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 1.7932, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 22.1893, tolerance = 1e-4, scale = 1)
})

test_that("outcome misclassification (D): observed measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "outcome",
                      reps = 50000,
                      seca.parms = list("uniform", c(.8, 1)),
                      seexp.parms = list("uniform", c(.7, .95)),
                      spca.parms = list("uniform", c(.8, 1)),
                      spexp.parms = list("uniform", c(.7, .95)),
                      corr.se = .8, corr.sp = .8,
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 1.6470, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 1.1824, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 2.2941, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 1], 1.7603, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 2], 1.2025, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 3], 2.5769, tolerance = 1e-4, scale = 1)
})

test_that("outcome misclassification: adjusted measures are correct", {
    set.seed(123)
    model <- probsens(matrix(c(45, 94, 257, 945), nrow = 2, byrow = TRUE),
                      type = "outcome",
                      reps = 50000,
                      seca.parms = list("uniform", c(.8, 1)),
                      seexp.parms = list("uniform", c(.7, .95)),
                      spca.parms = list("uniform", c(.8, 1)),
                      spexp.parms = list("uniform", c(.7, .95)),
                      corr.se = .8, corr.sp = .8,
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 4.8303, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 2.1173, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 50.2278, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 5.4494, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 2.2103, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 57.4525, tolerance = 1e-4, scale = 1)
})

test_that("Selection bias: observed measures are correct", {
    set.seed(123)
    model <- probsens.sel(matrix(c(136, 107, 297, 165), nrow = 2, byrow = TRUE),
                      reps = 50000,
                      or.parms = list("triangular", c(.35, 1.1, .43)),
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 0.7061, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 0.5144, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 0.9693, tolerance = 1e-4, scale = 1)
})

test_that("Selection bias: adjusted measures are correct", {
    set.seed(123)
    model <- probsens.sel(matrix(c(136, 107, 297, 165), nrow = 2, byrow = TRUE),
                      reps = 50000,
                      or.parms = list("triangular", c(.35, 1.1, .43)),
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 1.1850, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 0.7160, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 1.8153, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 1.1793, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 0.6456, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 2.0608, tolerance = 1e-4, scale = 1)
})

test_that("Confounding bias: observed measures are correct", {
    set.seed(123)
    model <- probsens.conf(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                      reps = 50000,
                      prev.exp = list("triangular", c(.7, .9, .8)),
                      prev.nexp = list("trapezoidal", c(.03, .04, .05, .06)),
                      risk = list("triangular", c(.6, .7, .63)),
                      corr.p = .8,
                      print = FALSE)
    expect_equal(model$obs.measures[1, 1], 0.3479, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 2], 0.2757, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[1, 3], 0.4390, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 1], 0.2180, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 2], 0.1519, tolerance = 1e-4, scale = 1)
    expect_equal(model$obs.measures[2, 3], 0.3128, tolerance = 1e-4, scale = 1)
})

test_that("Confounding bias: adjusted measures are correct", {
    set.seed(123)
    model <- probsens.conf(matrix(c(105, 85, 527, 93), nrow = 2, byrow = TRUE),
                      reps = 50000,
                      prev.exp = list("triangular", c(.7, .9, .8)),
                      prev.nexp = list("trapezoidal", c(.03, .04, .05, .06)),
                      risk = list("triangular", c(.6, .7, .63)),
                      corr.p = .8,
                      print = FALSE)
    expect_equal(model$adj.measures[1, 1], 0.4790, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 2], 0.4531, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[1, 3], 0.5082, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 1], 0.4785, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 2], 0.3769, tolerance = 1e-4, scale = 1)
    expect_equal(model$adj.measures[2, 3], 0.6094, tolerance = 1e-4, scale = 1)
})