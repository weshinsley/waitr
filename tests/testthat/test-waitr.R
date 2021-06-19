context("waitr")

test_that("Unitialised first use", {
  expect_equal(waitr::waitr_timestamp(), 0)
})

test_that("Reset works", {
  t <- waitr::waitr_reset()
  Sys.sleep(1)
  expect_equal(waitr::waitr_reset(), 0)
})

test_that("Delay works", {
  t <- waitr::waitr_reset()
  t <- waitr::waitr_delay(500)
  expect_true(t>=500 & t<=600)
  t <- system.time(waitr::waitr_delay(500))
  expect_true(t[['elapsed']] >= 0.4 & t[['elapsed']] <= 0.6)
})

test_that("Until works", {
  t <- waitr::waitr_reset()
  t <- waitr::waitr_until(500)
  expect_true(t >= 500 & t <= 550)
  t <- waitr::waitr_until(200)
  expect_true(t >= 500 & t <= 550)
})
