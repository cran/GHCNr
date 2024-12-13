## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(GHCNr)
library(terra)  # for handling countries geometries

## ----download-inventory, eval=FALSE-------------------------------------------
#  inventory_file <- download_inventory("~/Downloads/ghcn-inventory.txt")
#  stations <- stations(inventory_file, variables = "TMAX")

## ----read-inventory-----------------------------------------------------------
stations <- stations(variables = "TMAX")

## ----filter-by-year-----------------------------------------------------------
stations <- stations[stations$startYear <= 1990, ]
stations <- stations[stations$endYear >= 2000, ]
stations

## ----get-country--------------------------------------------------------------
italy <- get_country("ITA")

## ----spatial-filter-----------------------------------------------------------
stations <- filter_stations(stations, italy)
plot(italy)
points(stations[, c("longitude", "latitude")], pch = 20, col = "dodgerblue")

## ----daily--------------------------------------------------------------------
daily_ts <- daily(
  stations$station[1],
  paste("1990", "01", "01", sep = "-"),  # shorten a bit as example
  paste(stations$endYear[1], "12", "21", sep = "-"),
  variables = "tmin"
)
daily_ts

## ----multidaily---------------------------------------------------------------
daily_ts <- daily(
  stations$station,
  paste("1990", "01", "01", sep = "-"),  # shorten a bit as example
  paste("1991", "12", "31", sep = "-"),  # shorten a bit as example
  variables = "tmin"
)
daily_ts
plot(daily_ts, "tmin")

## ----flags, echo=FALSE--------------------------------------------------------
as.list(GHCNr:::.flags(strict = FALSE))

## ----flags-strict, echo=FALSE-------------------------------------------------
setdiff(GHCNr:::.flags(strict = TRUE), GHCNr:::.flags(strict = FALSE))

## ----remove-flagged-----------------------------------------------------------
daily_ts <- remove_flagged(daily_ts)
plot(daily_ts, "tmin")

## ----daily-coverage-----------------------------------------------------------
station_coverage <- coverage(daily_ts)

## ----low-coverage-------------------------------------------------------------
station_coverage[station_coverage$annual_coverage_tmin < 0.5, ]

## ----plot-timeseries, echo=FALSE, fig.width=6, fig.height = 4-----------------
palette <- hcl.colors(length(unique(daily_ts$station)), "Cork")
with(
  daily_ts,
    interaction.plot(
    date,
    station,
    tmin,
    col = palette,
    xlab = "Date",
    ylab = "TMIN",
    trace.label = "Station",
    lty = 1
  )
)

## ----monthly------------------------------------------------------------------
monthly_ts <- monthly(daily_ts)
monthly_ts
plot(monthly_ts, "tmin")

## ----annual-------------------------------------------------------------------
annual_ts <- annual(daily_ts)
annual_ts
plot(annual_ts, "tmin")
# normals <- normal(daily_ts) # to be implemented

