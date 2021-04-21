#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.10 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)

thin<-read.in("../../DataSets/DNA/DNA-TFC50.txt",22,3)

#########################################################################################

## Note that we have several different possible choices for Procrustes tangent coordinates. 

## Using partial Procrustes tangent coordinates: 

ans<-procGPA(thin,scale=TRUE,tangentcoords="partial")
ans$scores[,1]<-ans$scores[,1]*(-1)  #flip signs to match the book view
ans$scores[,3]<-ans$scores[,3]*(-1)  #flip signs to match the book view
pairs(cbind(ans$size,ans$scores[,1:3]),labels=c("size","PC1","PC2","PC3"))
ans$percent


#The actual plot seen in Figure 8.10 uses the Procrustes residuals  
#as approximate tangent coordinates. Here the choices of tangent coordinates are extremely similar. 
#Note the scaling of the scores is different, but the pairwise plots are extremely similar
#up to a common scale.

ans<-procGPA(thin,scale=TRUE,tangentcoords="residual")
pairs(cbind(ans$size,ans$scores[,1:3]),labels=c("size","PC1","PC2","PC3"))
ans$percent





