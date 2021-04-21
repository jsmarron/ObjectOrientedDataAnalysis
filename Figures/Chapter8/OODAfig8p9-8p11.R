#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.9 and 8.11 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)

thin<-read.in("../../DataSets/DNA/DNA-TFC50.txt",22,3)

ans<-pnss3d( thin , sphere.type="BIC",  n.pc=20)

#Figure 8.9

aa<-plot3darcs(ans,c=1,pcno=1,view.theta=-45,view.phi=-50,type="pca")
rgl.postscript("dna-pca1.pdf",fmt="pdf")
aa<-plot3darcs(ans,c=1,pcno=2,view.theta=-45,view.phi=-50,type="pca")
rgl.postscript("dna-pca2.pdf",fmt="pdf")
aa<-plot3darcs(ans,c=1,pcno=3,view.theta=-45,view.phi=-50,type="pca")
rgl.postscript("dna-pca3.pdf",fmt="pdf")

#Figure 8.11

aa<-plot3darcs(ans,c=1,pcno=1,view.theta=-45,view.phi=-50)
rgl.postscript("dna-pns1.pdf",fmt="pdf")
aa<-plot3darcs(ans,c=1,pcno=2,view.theta=-45,view.phi=-50)
rgl.postscript("dna-pns2.pdf",fmt="pdf")
aa<-plot3darcs(ans,c=1,pcno=3,view.theta=-45,view.phi=-50)
rgl.postscript("dna-pns3.pdf",fmt="pdf")



