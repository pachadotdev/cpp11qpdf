test_that("password callback works", {
  pdf_file <- 'password.pdf'
  expect_type(pdf_compress(pdf_file, tempfile(), password = "userpwd"), "character")
  expect_error(pdf_compress(pdf_file, tempfile()))
  options(askpass = function(...){'userpwd'})
  expect_type(pdf_compress(pdf_file, tempfile()), 'character')
  expect_error(pdf_compress(pdf_file, tempfile(), password = 'wrong'))
  expect_error(pdf_compress(pdf_file, tempfile(), password = " "))
  expect_error(pdf_compress(pdf_file, tempfile(), password = NA))
  expect_error(pdf_compress(pdf_file, tempfile(), password = NULL))
  expect_error(pdf_compress(pdf_file, tempfile(), password = ""))
  options(askpass = NULL)
})
