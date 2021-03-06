% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objects.R
\name{convert_to_seurat}
\alias{convert_to_seurat}
\title{Convert an SCE object to Seurat}
\usage{
convert_to_seurat(x, targets = TRUE, meta = TRUE, ...)
}
\arguments{
\item{x}{An SCE object.}

\item{targets}{Logical indicating whether to remove droplets called as debris. Default is TRUE.}

\item{meta}{Logical that indicates whether to place the data from droplet_info into meta.data in the 
resulting Seurat object. Default is TRUE.}

\item{...}{Arguments to \code{\link[Seurat]{CreateSeuratObject}}, such as \code{project} for project name.}
}
\value{
A Seurat object
}
\description{
Convert an SCE object to a Seurat object. if \code{targets} is true (default), output only droplets that are 
called as not debris. If \code{meta} is TRUE, then output meta data from droplet_info to the meta.data 
slot in the Seurat object. Additional functions \code{...} to this function are passed onto 
\code{\link[Seurat]{CreateSeuratObject}}. Common arguments include \code{min.cells = 3} and 
\code{min.features = 200}.
}
\examples{
\donttest{
mm_seur <- convert_to_seurat(x = mb_small, 
                             targets = FALSE, 
                             min.features = 500, 
                             min.cells = 3, 
                             project = mb_small@name)
}
}
