
test_that("id error messages", {

  skip_if_offline()
  skip_if_http_error()

  expect_error(ons_get(), "must specify")
  expect_error(
    ons_get(c("ageing-population-estimates", "trade")),
    "trying to access multiple files"
  )
})

test_that("id works", {
  skip_if_offline()
  skip_if_http_error()

  expect_error(ons_get("cpih01"), NA)
  expect_error(ons_get("ageing-population-estimates" ), NA)
})

