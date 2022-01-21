# skip_if_interactive() # to avoid opening tabs
skip(TRUE)
test_that("browse url", {

  expect_identical(
    ons_browse(),
    "https://developer.ons.gov.uk/"
  )
  expect_identical(
    ons_browse_qmi("cpih01"),
    "https://www.ons.gov.uk/economy/inflationandpriceindices/methodologies/consumerpriceinflationincludesall3indicescpihcpiandrpiqmi"
  )
})
