% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/daily.R
\name{daily}
\alias{daily}
\title{Download Daily Summaries}
\usage{
daily(station_id, start_date, end_date, variables = c("tmax", "tmin", "prcp"))
}
\arguments{
\item{station_id}{Character, station id(s).}

\item{start_date}{Character, start date.}

\item{end_date}{Character, end date.}

\item{variables}{Character, vector of the variables to include.}
}
\value{
A tibble with the daily timeseries at the stations.
}
\description{
Download Daily Summaries
}
\details{
\emph{station_id} can be a vector with multiple stations.
Dates should be given in \code{YYYY-mm-dd} format.
Available \emph{variables} can be found at \url{https://www.ncei.noaa.gov/pub/data/ghcn/daily/readme.txt}.
}
\examples{
\dontrun{
CA003076680 <- daily("CA003076680", "1990-01-01", "2024-12-31") 
}
}
