% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects.R
\name{Alpha}
\alias{Alpha}
\title{Get Alpha parameters for clusters}
\usage{
Alpha(x, k_init = NULL)
}
\arguments{
\item{x}{An SCE object.}

\item{k_init}{The k_init run to extract the values from.}
}
\value{
A droplet by cluster matrix containing the alpha parameters of 
 of the Dirichlet-multinomial cluster in each column.
}
\description{
Get Alpha parameters for clusters
}
