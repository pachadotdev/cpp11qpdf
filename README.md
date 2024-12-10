
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cpp11qpdf

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachadotdev/cpp11qpdf/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachadotdev/cpp11qpdf/actions/workflows/R-CMD-check.yaml)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

## About

The `cpp11qpdf` package provides a set of functions to manipulate PDF
files using the `qpdf` library.

## Installation

You can install the development version of cpp11qpdf like so:

``` r
remotes::install_github("pachadotdev/cpp11qpdf")
```

## Example

All functions take one or more input and output pdf files.

``` r
tmpdir <- tempdir()
library(cpp11qpdf)
file <- file.path(Sys.getenv("R_DOC_DIR"), "NEWS.pdf")
pdf_compress(file, file.path(tmpdir, "output.pdf"))
#> [1] "/tmp/RtmpNx4LFI/output.pdf"
```
