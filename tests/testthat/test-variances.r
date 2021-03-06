test_that("define_level_slope_variances",{
  result <- define_level_slope_variances("variable_of_interest_name")
  expect_equal(result, 'variable_of_interest_name_level ~~ variable_of_interest_name_level')
})


test_that("define_level_slope_variances - with include_slopes true",{
  result <- define_level_slope_variances("pop", TRUE)
  pasteResult <- paste(
    'pop_level ~~ pop_level',
    'pop_level ~~ pop_slope',
    'pop_slope ~~ pop_slope',
    sep = "\n"
  )
  expect_equal(result, pasteResult)
})


test_that("define_level_slope_variances - with include_slopes true and constrain_group_variances_to_be_equal is TRUE",{
  result <- define_level_slope_variances("pop", TRUE, TRUE)
  pasteResult <- paste(
    'pop_level ~~ c(LV,LV)*pop_level',
    'pop_level ~~ c(LSV,LSV)*pop_slope',
    'pop_slope ~~ c(SV,SV)*pop_slope',
    sep = "\n"
  )
  expect_equal(result, pasteResult)
})
