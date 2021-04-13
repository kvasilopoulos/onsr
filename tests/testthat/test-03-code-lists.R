test_that("spec id", {

  expect_error(ons_codelists(), NA)
  expect_error(ons_codelist("quarter"), NA)
  expect_error(ons_codelist("quarter2"), "Invalid")

  expect_error(ons_codelist_editions("quarter"), NA)
  expect_error(ons_codelist_edition("quarter", "one-off"), NA)
  expect_error(ons_codelist_edition("quarter", "one-off2"), "invalid")
})


test_that("spec code" ,{

  expect_error(ons_codes(code_id = "quarter", edition = "one-off"), NA)
  expect_error(ons_codes(code_id = "quarter", edition = "one-off2"), "invalid")

  expect_error(ons_code(code_id = "quarter", edition = "one-off", code = "q2"), NA)
  expect_error(ons_code(code_id = "quarter", edition = "one-off", code = "q23"), "invalid")

})
