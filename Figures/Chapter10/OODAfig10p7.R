#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 10.7 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)
B<-10000
X<-array(0,c(2,2,B))
Y<-X
W<-matrix(0,3,B)
Z<-W
Z2<-Z
Z3<-Z
Z4<-Z
Z5<-Z
for (i in 1:B){
X[,,i]<-matrix(rnorm(4),2,2)
Y[,,i]<-X[,,i]%*%t(X[,,i])
W[,i]<-c(Y[1,1,i],Y[1,2,i],Y[2,2,i])
Z[,i]<-c(Y[1,1,i],-Y[1,1,i],Y[1,1,i])
Z2[,i]<-c(Y[1,1,i],Y[1,1,i],Y[1,1,i])
Z3[,i]<-c(Y[1,1,i],0,0)
Z4[,i]<-c(0,0,Y[1,1,i])
Z5[,i]<-c(Y[1,1,i],0,Y[1,1,i])
}

points3d(t(Z),col=4) #blue
points3d(t(Z2),col=5) #cyan
points3d(t(Z3),col=7) #yellow
points3d(t(Z4),col=3) #green
points3d(t(Z5),col=8) #grey
axes3d()
rgl.material(alpha=0.1,shinyness=100)
points3d(t(W),col=2)


