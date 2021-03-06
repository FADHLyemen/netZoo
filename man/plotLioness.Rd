% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotLioness.R
\name{plotLioness}
\alias{plotLioness}
\title{Plot single-sample network}
\usage{
plotLioness(col = 0, top = 100, file = "lioness_top_100.png")
}
\arguments{
\item{col}{Numerical Vector indicating the index (0-based)of specified sample in a population. Defaults to 0.}

\item{top}{Numeric Vector indicating the amount of edges selected to plot by decreasting order of egde weights. Defaults to 100.}

\item{file}{Character String indicating the name of output .png file. Defaults to 'lioness_top_100.png'.}
}
\value{
A message showing the path of output plot.
}
\description{
This function is able to plot sepecified amount of edges in a specified sample network.
This function should be used following the \code{\link{runLioness}}.
As LIONESS estimates the single-sample network of an aggregate network generated by PANDA (more )
}
\examples{
# refer to the input datasets files of control in inst/extdat as example
control_expression_file_path <- system.file("extdata", "expr10.txt", package = "netZoo", mustWork = TRUE)
motif_file_path <- system.file("extdata", "chip.txt", package = "netZoo", mustWork = TRUE)
ppi_file_path <- system.file("extdata", "ppi.txt", package = "netZoo", mustWork = TRUE)

# Run PANDA algorithm
control_lioness_result <- runLioness(e = control_expression_file_path, m = motif_file_path, ppi = ppi_file_path, rm_missing = TRUE )

# plot the top 100 egdes in first sample network.
plotLioness(col = 0, top = 100, file = "top100_sample1.png")

}
