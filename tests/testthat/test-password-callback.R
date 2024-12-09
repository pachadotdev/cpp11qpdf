test_that("password callback works", {
  pdf_file <- 'pdf-example-password.original.pdf'
  expect_type(pdf_compress(pdf_file, tempfile(), password = "test"), "character")
  expect_error(pdf_compress(pdf_file, tempfile()))
  options(askpass = function(...){'test'})
  expect_type(pdf_compress(pdf_file, tempfile()), 'character')
  expect_error(pdf_compress(pdf_file, tempfile(), password = 'wrong'))
  options(askpass = NULL)
})
