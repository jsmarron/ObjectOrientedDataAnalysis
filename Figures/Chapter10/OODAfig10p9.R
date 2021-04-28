#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 10.9 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
x<-read.in("../../DataSets/novel-distances.txt", 23, 23)

#read in the distances between the novels using various metrics

DmatF<-x[,,1]
DmatL1<-x[,,2]
DmatLh<-x[,,3]
DmatL3<-x[,,4]
DmatL4<-x[,,5]
DmatO<-x[,,6]
DmatI<-x[,,7]
DmatM<-x[,,8]

z<-scan("../../DataSets/dickens-austen-ids.txt",what="")
dickens_austen_ids<-z



par(mfrow=c(4,4))   
novcol<-c(rep(2,times=16),rep(4,times=7))
dickens_austen_ids[17:23]<-c("em","pe","pr","ls","ma","no","se")

dend<-hclust(as.dist(DmatF),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(DmatF),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(DmatF),labels=dickens_austen_ids,col=novcol)
title("Frobenius")



dend<-hclust(as.dist(DmatL1),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(DmatL1),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(DmatL1),labels=dickens_austen_ids,col=novcol)
title("Entrywise L_1")


dend<-hclust(as.dist(DmatLh),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(DmatLh),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(DmatLh),labels=dickens_austen_ids,col=novcol)
title("Entrywise L_1/2")

Dmat<-DmatL3
dend<-hclust(as.dist(Dmat),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(Dmat),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(Dmat),labels=dickens_austen_ids,col=novcol)
title("Entrywise L_3")

Dmat<-DmatL4
dend<-hclust(as.dist(Dmat),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(Dmat),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(Dmat),labels=dickens_austen_ids,col=novcol)
title("Entrywise L_0.75")



Dmat<-DmatO
dend<-hclust(as.dist(Dmat),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(Dmat),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(Dmat),labels=dickens_austen_ids,col=novcol)
title("Sparse norm O")

Dmat<-DmatI
dend<-hclust(as.dist(Dmat),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(Dmat),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(Dmat),labels=dickens_austen_ids,col=novcol)
title("Sparse norm I")

Dmat<-DmatM
dend<-hclust(as.dist(Dmat),method="ward.D2") 
plot(dend,labels=dickens_austen_ids)
set.seed(1)
plot(cmdscale(Dmat),type="n",xlab="MDS1",ylab="MDS2")
text(cmdscale(Dmat),labels=dickens_austen_ids,col=novcol)
title("Sparse norm M")
