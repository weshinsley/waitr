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
  t <- waitr::wait_for(500)
  expect_true(t>=500 & t<=600)
})

test_that("Real time approx", {
  t <- system.time(waitr::wait_for(2000))
  expect_true(t[['elapsed']] >= 1.9 & t[['elapsed']] <= 2.3)
})

test_that("Until works", {
  t <- waitr::waitr_reset()
  t <- waitr::wait_until(2000)
  expect_true(t >= 2000 & t <= 2500)
  t <- waitr::wait_until(1500)
  expect_true(t >= 2000 & t <= 2500)
})
