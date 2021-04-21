#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 7.11 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes and rgl library installing: e.g. install.packages("shapes")

# Note that this produces 3D rgl views, which are then rotated by hand 
# to give the views in the Figure. 

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)
set.seed(10)


#read in data
thin<-read.in("../../DataSets/DNA/DNA-TFC50.txt",22,3)

dna.tfc<-array(0,c(22,3,2))
dna.tfc[,,1]<-thin[,,1]
dna.tfc[,,2]<-thin[,,50]


jj<-c(11:1,22,21,2,3,20,19,4,5,18,17,6,7,16,15,  8,9,14,13, 10, 11, 12:22)
cc<-c(rep(2,times=22),rep(4,times=22))
a<-matrix( rnorm(9), 3,3)
R <- eigen(a%*%t(a))$vectors
C<-t(defh(21))%*%defh(21)

dna1<-abind(dna.tfc[,,1], dna.tfc[,,2])
dna2<-abind(C%*%(dna.tfc[,,1])%*%R+rep(1,times=22)%*%t(c(0,10,0)), dna.tfc[,,2])
dna3<-abind(C%*%dna.tfc[,,1]%*%R, C%*%dna.tfc[,,2])
dna4<-abind(C%*%dna.tfc[,,1]%*%R, 
            procOPA(C%*%dna.tfc[,,1]%*%R ,C%*%dna.tfc[,,2], scale=TRUE)$Bhat)
print(riemdist(C%*%dna.tfc[,,1]%*%R, C%*%dna.tfc[,,2]))


##### Note that 3D rgl plots are produced which are then rotated by hand to get the views in the figures


shapes3d(dna2,col=cc,joinline=jj)

shapes3d(dna4,col=cc,joinline=jj)


A<-thin[,,1]
B<-thin[,,50]
print(riemdist(A,B))
print(sin(riemdist(A,B)))
print(2*sin(riemdist(A,B)/2))

#print(riemdist(A,B))
#[1] 0.1464013
#> print(sin(riemdist(A,B)))
#[1] 0.1458788
#> print(2*sin(riemdist(A,B)/2))
#[1] 0.1462706

#################
