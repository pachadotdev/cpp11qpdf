#' PDF Functions
#' @export
#' @name cpp11qpdf
#' @rdname cpp11qpdf
#' @importFrom askpass askpass
#' @param input path or url to the input pdf file
#' @param output base path of the output file(s)
#' @param password string with password to open pdf file
#' @examples \donttest{
#' # extract some pages
#' pdf_file <- system.file("examples", "sufganiyot.pdf", package = "cpp11qpdf")
#' pdf_subset(pdf_file, 1, pdf_file, password = "")
#' pdf_length(pdf_file, password = "")
#' }
pdf_split <- function(input, output = NULL, password = askpass::askpass()){
  input <- get_input(input)
  if(!length(output))
    output <- sub("\\.pdf$", "", input)
  cpp_pdf_split(input, output, password)
}

#' @export
#' @rdname cpp11qpdf
pdf_length <- function(input, password = askpass::askpass()){
  input <- get_input(input)
  cpp_pdf_length(input, password)
}

#' @export
#' @rdname cpp11qpdf
#' @param pages a vector with page numbers to select. Negative numbers
#' means removing those pages (same as R indexing)
pdf_subset <- function(input, pages = 1, output = NULL, password = askpass::askpass()){
  input <- get_input(input)
  if(!length(output))
    output <- sub("\\.pdf$", "_output.pdf", input)
  output <- normalizePath(output, mustWork = FALSE)
  size <- pdf_length(input, password = password)
  pages <- seq_len(size)[pages]
  if(any(is.na(pages)) || !length(pages))
    stop("Selected pages out of range")
  cpp_pdf_select(input, output, pages, password)
}

#' @export
#' @rdname cpp11qpdf
pdf_combine <- function(input, output = NULL, password = askpass::askpass()){
  input <- get_input_multi(input)
  if(!length(output))
    output <- sub("\\.pdf$", "_combined.pdf", input[1])
  output <- normalizePath(output, mustWork = FALSE)
  cpp_pdf_combine(input, output, password)
}

#' @export
#' @rdname cpp11qpdf
#' @param linearize enable pdf linearization (streamable pdf)
pdf_compress <- function(input, output = NULL, linearize = FALSE, password = askpass::askpass()){
  input <- get_input(input)
  if(!length(output))
    output <- sub("\\.pdf$", "_output.pdf", input)
  output <- normalizePath(output, mustWork = FALSE)
  cpp_pdf_compress(input, output, linearize, password)
}

#' @export
#' @rdname cpp11qpdf
#' @param stamp pdf file of which the first page is overlayed into each page of input
pdf_overlay_stamp <- function(input, stamp, output = NULL, password = askpass::askpass()){
  input <- get_input(input)
  stamp <- get_input(stamp)
  if(!length(output))
    output <- sub("\\.pdf$", "_output.pdf", input)
  output <- normalizePath(output, mustWork = FALSE)
  cpp_pdf_overlay(input, stamp, output, password)
}

#' @export
#' @rdname cpp11qpdf
#' @param pages a vector with page numbers to rotate
#' @param angle rotation angle in degrees (positive = clockwise)
#' @param relative if `TRUE`, pages are rotated relative to their current orientation. If `FALSE`, rotation is absolute (0 = portrait, 90 = landscape, rotated 90 degrees clockwise from portrait)
pdf_rotate_pages <- function(input, pages, angle = 90, relative = FALSE, output = NULL, password = askpass::askpass()){
  input <- get_input(input)
  if(!length(output))
    output <- sub("\\.pdf$", "_output.pdf", input)
  output <- normalizePath(output, mustWork = FALSE)
  size <- pdf_length(input, password = password)
  pages <- seq_len(size)[pages]
  if(any(is.na(pages)) || !length(pages))
    stop("Selected pages out of range")
  cpp_pdf_rotate_pages(input, output, pages, angle, relative, password)
}

password_callback <- function(...){
  paste(askpass::askpass(...), collapse = "")
}

get_input <- function(path){
  if(length(path) != 1)
    stop("input should contain exactly one file")
  if(grepl("^https?://", path)){
    tmp <- file.path(tempdir(), basename(path))
    curl::curl_download(path, tmp)
    path <- tmp
  }
  normalizePath(path, mustWork = TRUE)
}

get_input_multi <- function(path){
  vapply(path, get_input, character(1))
}
