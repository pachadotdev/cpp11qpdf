% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qpdf.R
\name{pdf_combine}
\alias{pdf_combine}
\title{Combine multiple pdf files into a single pdf file}
\usage{
pdf_combine(input, output = NULL, password = "")
}
\arguments{
\item{input}{path or url to the input pdf file}

\item{output}{base path of the output file(s)}

\item{password}{string with password to open pdf file}
}
\value{
a character vector with the path of the combined pdf file
}
\description{
Combine multiple pdf files into a single pdf file
}
\examples{
pdf_file <- system.file("examples", "sufganiyot.pdf", package = "cpp11qpdf")
fout <- tempfile()
pdf_combine(pdf_file, fout, "")
}
