# PandaCondor

An R package to integrate [pypanda](https://github.com/davidvi/pypanda)--Python implementation of PANDA and R implementation of [CONDOR](https://github.com/jplatig/condor).

**PANDA**(Passing Attributes between Networks for Data Assimilation) is a message-passing model to gene regulatory network reconstruction. It integrates multiple sources of biological data, including protein-protein interaction, gene expression, and sequence motif information, in order to reconstruct genome-wide, condition-specific regulatory networks.[[Glass et al. 2013]](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0064832)

**CONDOR** (COmplex Network Description Of Regulators) implements methods for clustering biapartite networks
and estimatiing the contribution of each node to its community's modularity.[[Platig et al. 2016]](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005033)

## Getting Started

### Prerequisites
This pacakage requires Python 2.7 and R (>= 3.3.2) and Internet access.

### Installing
This package could be downloaded via `install_github()` function from `devtools` package.

```R
install.packages("devtools")
library(devtools)
devtools::install_github("twangxxx/PandaCondor")

```

## Running the tests

Package [CONDOR](https://github.com/jplatig/condor), [igprah](http://igraph.org/r/), and [viridisLite](https://cran.r-project.org/web/packages/viridisLite/index.html) are loaded while this package is loaded.
Use search() to check all loaded package currently.
```R
library(PandaCondor)
search()
```
Access help pages of two primariy functions.
```
?runPanda
?runCondor
```
Use example datasets within package to test this package.

Refer to four input datasets files: one TB control expression dataset, one treated expression dataset, one motif sequence dataset, and one protein-protein interaction datasets in inst/extdat.
```R
treated_expression_file_path <- system.file("extdata", "expr4.txt", package = "PandaCondor", mustWork = TRUE)
control_expression_file_path <- system.file("extdata", "expr10.txt", package = "PandaCondor", mustWork = TRUE)
motif_file_path <- system.file("extdata", "chip.txt", package = "PandaCondor", mustWork = TRUE)
ppi_file_path <- system.file("extdata", "ppi.txt", package = "PandaCondor", mustWork = TRUE)
```
Use three file paths and rm_missing option TRUE to run PANDA for treated and control network.
`treated_all_panda_result` and `control_all_panda_result` below are large lists with three items: the entire PANDA network, indegree nodes and score, outdegree nodes and score. Use `$panda`,`$indegree` and '$outdegree' to access each item.

```R
treated_all_panda_result <- runPanda(e = treated_expression_file_path, m = motif_file_path, ppi = ppi_file_path, rm_missing = TRUE )
control_all_panda_result <- runPanda(e = control_expression_file_path, m = motif_file_path, ppi = ppi_file_path, rm_missing = TRUE )
```
Use `$panda`to access the entire PANDA network.
```R
treated_net <- treated_all_panda_result$panda
control_net <- control_all_panda_result$panda
```
Select all edge having weights over 0 and run CONDOR
```R
treated_condor_object <- runCondor(treated_net, threshold = 0)
control_condor_object <- runCondor(control_net, threshold = 0)
```

plot communities. package igraph and package viridisLite (a color map) are already loaded with this package.

*treated network*:
```R
treated_color_num <- max(treated_condor_object$red.memb$com)
treated_color <- viridis(treated_color_num, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")
condor.plot.communities(treated_condor_object, color_list=treated_color, point.size=0.04, xlab="Target", ylab="Regulator")
```

*control network*:
```R
control_color_num <- max(control_condor_object$red.memb$com)
control_color <- viridis(control_color_num, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")
condor.plot.communities(control_condor_object, color_list=control_color , point.size=0.04, xlab="Target", ylab="Regulator")
```
