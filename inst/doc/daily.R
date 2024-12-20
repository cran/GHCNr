## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(GHCNr)
library(terra)  # for handling countries geometries

## ----download-inventory, eval=FALSE-------------------------------------------
#  inventory_file <- download_inventory("~/Downloads/ghcn-inventory.txt")
#  s <- stations(inventory_file, variables = "TMAX")

## ----read-inventory, eval=FALSE-----------------------------------------------
#  s <- stations(variables = "TMAX")

## ----filter-by-year, eval=FALSE-----------------------------------------------
#  s <- s[s$startYear <= 1990, ]
#  s <- s[s$endYear >= 2000, ]
#  s
#  # A tibble: 16,763 × 6
#     station     latitude longitude variable startYear endYear
#     <chr>          <dbl>     <dbl> <chr>        <dbl>   <dbl>
#   1 AE000041196     25.3     55.5  TMAX          1944    2024
#   2 AEM00041194     25.3     55.4  TMAX          1983    2024
#   3 AEM00041217     24.4     54.7  TMAX          1983    2024
#   4 AFM00040938     34.2     62.2  TMAX          1973    2020
#   5 AFM00040948     34.6     69.2  TMAX          1966    2021
#   6 AFM00040990     31.5     65.8  TMAX          1973    2020
#   7 AG000060390     36.7      3.25 TMAX          1940    2024
#   8 AG000060590     30.6      2.87 TMAX          1940    2024
#   9 AG000060611     28.0      9.63 TMAX          1958    2024
#  10 AG000060680     22.8      5.43 TMAX          1940    2004
#  # ℹ 16,753 more rows
#  # ℹ Use `print(n = ...)` to see more rows

## ----get-country, eval=FALSE--------------------------------------------------
#  italy <- get_country("ITA")

## ----spatial-filter, eval=FALSE-----------------------------------------------
#  s <- filter_stations(s, italy)
#  s
#  # A tibble: 41 × 6
#     station     latitude longitude variable startYear endYear
#     <chr>          <dbl>     <dbl> <chr>        <dbl>   <dbl>
#   1 IT000016090     45.4     10.9  TMAX          1951    2024
#   2 IT000016134     44.2     10.7  TMAX          1951    2024
#   3 IT000016232     42       15    TMAX          1975    2024
#   4 IT000016239     41.8     12.6  TMAX          1951    2024
#   5 IT000016320     40.6     17.9  TMAX          1951    2024
#   6 IT000016560     39.2      9.05 TMAX          1951    2024
#   7 IT000160220     46.2     11.0  TMAX          1951    2024
#   8 IT000162240     42.1     12.2  TMAX          1954    2024
#   9 IT000162580     41.7     16.0  TMAX          1951    2024
#  10 ITE00100554     45.5      9.19 TMAX          1763    2008
#  # ℹ 31 more rows
#  # ℹ Use `print(n = ...)` to see more rows

## ----daily, eval=FALSE--------------------------------------------------------
#  daily_ts <- daily(
#    station_id = "CA003076680",
#    start_date = paste("2002", "11", "01", sep = "-"),
#    end_date = paste("2024", "04", "22", sep = "-"),
#    variables = "tmax"
#  )
#  daily_ts

## ----daily-saved, echo=FALSE--------------------------------------------------
daily_ts <- CA003076680[, c("date", "station", "tmax", "tmax_flag")]
daily_ts

## ----multidaily, eval=FALSE---------------------------------------------------
#  daily_ts <- daily(
#    station_id = c("CA003076680", "USC00010655"),
#    start_date = paste("2002", "11", "01", sep = "-"),
#    end_date = paste("2024", "04", "22", sep = "-"),
#    variables = "tmax"
#  )
#  plot(daily_ts, "tmax")

## ----multidaily-saved, echo=FALSE---------------------------------------------
daily_ts <- rbind(CA003076680, USC00010655)[, c("date", "station", "tmax", "tmax_flag")]
plot(daily_ts, "tmax")

## ----flags, echo=FALSE--------------------------------------------------------
as.list(GHCNr:::.flags(strict = TRUE))

## ----flags-strict, echo=FALSE-------------------------------------------------
as.list(GHCNr:::.flags(strict = FALSE))

## ----remove-flagged-----------------------------------------------------------
daily_ts <- remove_flagged(daily_ts)
plot(daily_ts, "tmax")

## ----daily-coverage-----------------------------------------------------------
station_coverage <- coverage(daily_ts)
station_coverage

## ----low-coverage-------------------------------------------------------------
unique(station_coverage[
  station_coverage$annual_coverage_tmax < .95,
  c("station", "year", "annual_coverage_tmax")
])

## ----monthly------------------------------------------------------------------
monthly_ts <- monthly(daily_ts)
monthly_ts
plot(monthly_ts, "tmax")

## ----annual-------------------------------------------------------------------
annual_ts <- annual(daily_ts)
annual_ts
plot(annual_ts, "tmax")

