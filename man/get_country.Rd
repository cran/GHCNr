% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-country-shapefile.R
\name{get_country}
\alias{get_country}
\title{Download country shapefile from geoBoundaries}
\usage{
get_country(country_code, simplified = TRUE)
}
\arguments{
\item{country_code}{Three letter ISO code.}

\item{simplified}{Logical.}
}
\value{
A shapefile.
}
\description{
Download country shapefile from geoBoundaries
}
\details{
\url{https://github.com/wmgeolab/geoBoundaries}.
}
\examples{
\dontrun{
italy <- get_country("ITA")
}
}
