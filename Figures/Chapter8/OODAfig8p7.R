#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.7 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



library(shapes)
ans <- procGPA(digit3.dat,tangentcoords = "partial")
shapepca(ans)
 


