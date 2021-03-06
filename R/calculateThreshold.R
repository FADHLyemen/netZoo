#' Calculate the default threshold of edge-weight in PANDA network edges selections
#'
#'In a PANDA network, the 4th column is filled with the edge-weight calculated by Z-score formular.
#' \href{http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0064832/}{[(Glass et al. 2013)])}
#' This function transforms all the edge-weights into values above 0 by formular \eqn{w'=ln(e^w+1)} , then calculates 
#' the midpoint between the median edge-weight of prior ( 3rd column "Motif" is 1.0) edges and the median edge-weight of non-prior edges (3rd column "Motif" is 0.0) in PANDA network.
#'
#' @param df Data Frame indicating the entire network result of PANDA algorithm, it is created by \code{\link{runPanda}} and accessd by \code{$panda}.
#'
#' @return Numeric vector of the midpoint between two medians. One median is the median edge-weight of all prior edges, another is the meadian edge-weight of all non-prior edges.
#' 
#' @examples 
#' # refer to four input datasets files in inst/extdat
#' treated_expression_file_path <- system.file("extdata", "expr4.txt", package = "netZoo", mustWork = TRUE)
#' control_expression_file_path <- system.file("extdata", "expr10.txt", package = "netZoo", mustWork = TRUE)
#' motif_file_path <- system.file("extdata", "chip.txt", package = "netZoo", mustWork = TRUE)
#' ppi_file_path <- system.file("extdata", "ppi.txt", package = "netZoo", mustWork = TRUE)
#' 
#' 
#' # Run PANDA for treated and control network
#' treated_all_panda_result <- runPanda(e = treated_expression_file_path, m = motif_file_path, ppi = ppi_file_path, rm_missing = TRUE )
#' control_all_panda_result <- runPanda(e = control_expression_file_path, m = motif_file_path, ppi = ppi_file_path, rm_missing = TRUE )
#' 
#' # Access PANDA regulatory network
#' treated_net <- treated_all_panda_result$panda
#' control_net <- control_all_panda_result$panda
#' 
#' # Calculate the default threshold of edge-weight in a PANDA network.
#' calculateCutoff (treated_net )
#' 
#' @export


calculateThreshold <- function(df){
  
  # transforming edge weights 
  newdf <- cbind(df[,c(1,2,3)],log(exp(df[,4])+1))
  # rename the colnames
  colnames(newdf)[4] <- c("edge.Trans")
  
  # prior edges
  Motif <- newdf[newdf[,3] == 1,]
  # non-prior edges
  nonMotif <- newdf[newdf[,3] == 0,]
  
  # the median of prior edges and non-prior edges
  Motif.Median <- summary(Motif[,4])[[3]]
  nonMotif.Median <- summary(nonMotif[,4])[[3]]
  
  # midway of these two medians.
  cutoff <- 1/2 * (nonMotif.Median + Motif.Median)
  return(cutoff)
}

