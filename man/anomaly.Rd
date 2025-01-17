% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/anomaly.R
\name{anomaly}
\alias{anomaly}
\title{Temperature Anomaly}
\usage{
anomaly(x, cutoff, aggregate_stations = FALSE)
}
\arguments{
\item{x}{Object of class \code{ghcn_daily} or \code{ghcn_annual}. See \code{\link[=daily]{daily()}} and \code{\link[=annual]{annual()}} for details.}

\item{cutoff}{Numeric, last year of the baseline period (inclusive).}

\item{aggregate_stations}{Logical, if anomaly should be calculated aggregating data from all weather stations.}
}
\value{
A tibble with the anomaly timeseries at the stations.
}
\description{
\code{anomaly()} calculates the temperature anomalies compared to a baseline
reference period. Anomalies are the difference between annual temperature
extremes and the average across the baseline period.

If \code{aggregate_stations = TRUE}, anomalies are averaged across all weather stations.
}
\details{
\code{cutoff} must be a character with the date, e.g. "2000-01-01".
}
\examples{
x <- USC00010655
x <- remove_flagged(x)
cover <- annual_coverage(x)
years <- cover$year[cover$"annual_coverage_tmax" > .99 & cover$"annual_coverage_tmin" > .99]
years <- setdiff(years, 2024)
x$years <- as.numeric(format(x$date, "\%Y"))
x <- x[x$years \%in\% years, ]
a <- annual(x)
anom <- anomaly(a, cutoff = 2012)
plot(anom)
}
