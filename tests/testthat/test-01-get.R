
skip_if_offline()
skip_if_http_error()

test_that("id error messages", {
  expect_error(ons_get(), "must specify")
  expect_error(
    ons_get(c("ageing-population-estimates", "trade")),
    "trying to access multiple files"
  )
})

# test_that("id works", {
#   expect_error(ons_get("cpih01"), NA)
#   expect_error(ons_get("ageing-population-estimates" ), NA)
# })


test_that("obs specify the right dim",{

  # expect_error(
  #   ons_get_obs(
  #     "cpih01",
  #     geography = "K02000001",
  #     aggregate = "cpih1dim1A0",
  #     time = "Nov-93"
  #   ),
  #   NA
  # )

  msg <- "dimensions have been misspecified"
  expect_error(ons_get_obs("cpih01"), msg)
  expect_error(
    ons_get_obs(
      "cpih01",
      geographYY = "K02000001",
      aggregate = "cpih1dim1A0",
      time = "Nov-93"
    ),
    msg
  )


})
