
<!-- README.md is generated from README.Rmd. Please edit that file -->

# onsr

<!-- badges: start -->

[![R-CMD-check](https://github.com/kvasilopoulos/onsr/workflows/R-CMD-check/badge.svg)](https://github.com/kvasilopoulos/onsr/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/onsr)](https://CRAN.R-project.org/package=onsr)
<!-- badges: end -->

> ***NOTE:*** This API is currently in Beta and still being developed.
> Please be aware that as a result of this there may occasionally be
> breaking changes.

The goal of onsr is to to provide a client for the ‘Office of National
Statistics’ (‘ONS’) API <https://api.beta.ons.gov.uk/v1>.

## Installation

``` r
# Install release version from CRAN
install.packages("exuber")
```

You can install the development version of exuber from GitHub.

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/onsr")
```

If you encounter a clear bug, please file a reproducible example on
[GitHub](https://github.com/kvasilopoulos/onsr/issues).

## Example

This is a basic example which shows you how to download data with
`onsr`.

``` r
library(onsr)

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

# All the available id names
ons_ids()
#>  [1] "ageing-population-estimates"                  
#>  [2] "ageing-population-projections"                
#>  [3] "older-people-economic-activity"               
#>  [4] "older-people-net-internal-migration"          
#>  [5] "older-people-sex-ratios"                      
#>  [6] "projections-older-people-in-single-households"
#>  [7] "projections-older-people-sex-ratios"          
#>  [8] "weekly-deaths-age-sex"                        
#>  [9] "weekly-deaths-region"                         
#> [10] "online-job-advert-estimates"                  
#> [11] "faster-indicators-shipping-data"              
#> [12] "cpih01"                                       
#> [13] "mid-year-pop-est"                             
#> [14] "weekly-deaths-health-board"                   
#> [15] "weekly-deaths-local-authority"                
#> [16] "regional-gdp-by-year"                         
#> [17] "wellbeing-local-authority"                    
#> [18] "index-private-housing-rental-prices"          
#> [19] "suicides-in-the-uk"                           
#> [20] "childrens-wellbeing"                          
#> [21] "gdp-to-four-decimal-places"                   
#> [22] "generational-income"                          
#> [23] "health-accounts"                              
#> [24] "wellbeing-quarterly"                          
#> [25] "house-prices-local-authority"                 
#> [26] "regional-gdp-by-quarter"                      
#> [27] "labour-market"                                
#> [28] "tax-benefits-statistics"                      
#> [29] "ashe-tables-26"                               
#> [30] "ashe-tables-25"                               
#> [31] "ashe-tables-27-and-28"                        
#> [32] "trade"                                        
#> [33] "ashe-tables-7-and-8"                          
#> [34] "ashe-tables-3"                                
#> [35] "ashe-tables-11-and-12"                        
#> [36] "ashe-tables-20"                               
#> [37] "ashe-tables-9-and-10"                         
#> [38] "ashe-table-5"                                 
#> [39] "life-expectancy-by-local-authority"           
#> [40] "gdp-by-local-authority"                       
#> [41] "gva-by-industry-by-local-authority"
```

## Rate limiting

The ONS API applies rate limiting to ensure a high quality service is
delivered to all users and to protect client applications from
unexpected loops.

The following rate limits have been implemented:

-   120 requests per 10 seconds

-   200 requests per 1 minute

If you exceed these limits the API will return a 429 Too Many Requests
HTTP status code and a Retry-After header containing the number of
seconds until you may try your request again.
