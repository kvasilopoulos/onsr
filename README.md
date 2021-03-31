
<!-- README.md is generated from README.Rmd. Please edit that file -->

# onsr

<!-- badges: start -->

[![R-CMD-check](https://github.com/kvasilopoulos/onsr/workflows/R-CMD-check/badge.svg)](https://github.com/kvasilopoulos/onsr/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/onsr)](https://CRAN.R-project.org/package=onsr)
<!-- badges: end -->

The goal of onsr is to …

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/onsr")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(onsr)
## basic example code
ons_get(id = "ageing-population-estimates")
#> # A tibble: 18,960 x 12
#>     V4_1 `Data Marking` `calendar-years`  Time `administrative-g~ Geography  sex   Sex  
#>    <dbl> <chr>                     <dbl> <dbl> <chr>              <chr>      <chr> <chr>
#>  1    NA .                          2019  2019 E08000008          Tameside   fema~ Fema~
#>  2    NA .                          2019  2019 E12000009          South West fema~ Fema~
#>  3 83288 <NA>                       2019  2019 E08000006          Salford    fema~ Fema~
#>  4    NA .                          2019  2019 W92000004          Wales      male  Male 
#>  5    NA .                          2019  2019 E07000166          Richmonds~ all   All  
#>  6 55635 <NA>                       2019  2019 E06000034          Thurrock   fema~ Fema~
#>  7 14437 <NA>                       2019  2019 E07000108          Dover      fema~ Fema~
#>  8 10736 <NA>                       2019  2019 E07000131          Harborough fema~ Fema~
#>  9 12646 <NA>                       2019  2019 E07000106          Canterbury fema~ Fema~
#> 10  9450 <NA>                       2019  2019 E07000237          Worcester  fema~ Fema~
#> # ... with 18,950 more rows, and 4 more variables: age-groups <chr>, AgeGroups <chr>,
#> #   unit-of-measure <chr>, UnitOfMeasure <chr>
```
