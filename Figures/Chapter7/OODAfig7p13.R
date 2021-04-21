#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 7.13 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes and rgl library installing: e.g. install.packages("shapes")

# Note that this produces 3D rgl views, which are then rotated by hand 

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)

#read in data
thin<-read.in("../../DataSets/DNA/DNA-TFC50.txt",22,3)

#randomly rotated molecules 
set.seed(10)
dnarot <- thin
C<-t(defh(21))%*%defh(21)
for ( i in 1:50){
  theta<- -0.1*rnorm(1)
  phi<- -0.2*rnorm(1)
  rot1<- matrix( c(cos(theta),-sin(theta),0,sin(theta),cos(theta),0,0,0,1),3,3)
  rot2<- matrix( c(cos(phi),0,-sin(phi),0,1,0,sin(phi),0,cos(phi)),3,3)
  rot1<-t(rot1)
  dnarot[,,i]<- C%*%(dnarot[,,i])%*%rot1%*%rot2
}


#bonds etc for plots
jj<-c(11:1,22,21,2,3,20,19,4,5,18,17,6,7,16,15,8,9,14,13,10,11,12:22)

#plot randomly rotated data
shapes3d(dnarot,joinline=jj)

#Procrustes with scaling
shapes3d(procGPA(dnarot,scale=TRUE)$rotated,joinline=jj,col=3)


