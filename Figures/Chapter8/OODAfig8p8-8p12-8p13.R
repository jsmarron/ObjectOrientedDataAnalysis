#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.8, 8.12 and 8.13 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)

#########################################################################################

ans2<-pnss3d( digit3.dat , sphere.type="BIC", n.pc=20)
aa<-plot3darcs(ans2,c=2,pcno=1)
rgl.postscript("digit3-pns1.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=2)
rgl.postscript("digit3-pns2.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=3)
rgl.postscript("digit3-pns3.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=1,type="pca")
rgl.postscript("digit3-pca1.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=2,type="pca")
rgl.postscript("digit3-pca2.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=3,type="pca")
rgl.postscript("digit3-pca3.pdf",fmt="pdf")

ans2<-pnss3d( digit3.dat[,,2:30] , sphere.type="BIC", n.pc=20)
aa<-plot3darcs(ans2,c=2,pcno=1)
rgl.postscript("digit3a-pns1.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=2)
rgl.postscript("digit3a-pns2.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=3)
rgl.postscript("digit3a-pns3.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=1,type="pca")
rgl.postscript("digit3a-pca1.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=2,type="pca")
rgl.postscript("digit3a-pca2.pdf",fmt="pdf")
aa<-plot3darcs(ans2,c=2,pcno=3,type="pca")
rgl.postscript("digit3a-pca3.pdf",fmt="pdf")

