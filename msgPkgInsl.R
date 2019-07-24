### required packages ###
#RequiredPackages.csv

chkPkg <- function(ReqList = NULL,repository= "http://cran.rstudio.com")
{
  r <- as.character(repository)
  x <- as.character(ReqList)
  options ( repos = c(CRAN = r))
  
  reqpkg <- read.csv(x)
  #reqpkg <- read.csv("RequiredPackages.csv")
  reqpkg <- as.data.frame(reqpkg)
  colnames(reqpkg) <- "PackageName"
  
  inspkg <- as.data.frame(installed.packages())
  inspkg <- as.data.frame(inspkg[c("Package","Package")], row.names = NULL)
  colnames(inspkg) <- c("Package","PackageName")
  
  
  mispkg <- merge(x=reqpkg
                  ,y=inspkg
                  ,by.x = "PackageName"
                  ,by.y = "Package"
                  ,all.x = TRUE
  )
  colnames(mispkg) <- c("PackageName","PackageCheck")
  mispkg <- mispkg[which(is.na(mispkg$PackageCheck)== TRUE),]
  
  lapply(as.vector(mispkg$PackageName), install.packages, character.only = TRUE)
  
}