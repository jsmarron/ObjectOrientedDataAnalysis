#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.10 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)
set.seed(10)


tfc<-read.in("../../DataSets/DNA-12groups/TFC_P.x",22,3)


thin<-tfc[,,(1:50)*50]


#ans<-procGPA(thin,scale=FALSE)
#shapes3d(ans$rotated)
#pairs(cbind(ans$size,ans$scores[,1:3]))

dna.tfc<-array(0,c(22,3,2))
dna.tfc[,,1]<-thin[,,1]
dna.tfc[,,2]<-thin[,,50]


jj<-c(11:1,22,21,2,3,20,19,4,5,18,17,6,7,16,15,  8,9,14,13, 10, 11, 12:22)
cc<-c(rep(2,times=22),rep(4,times=22))
a<-matrix( rnorm(9), 3,3)
R <- eigen(a%*%t(a))$vectors
#determinant(R,logarithm=FALSE)
C<-t(defh(21))%*%defh(21)

dna1<-abind(dna.tfc[,,1], dna.tfc[,,2])
dna2<-abind(C%*%(dna.tfc[,,1])%*%R+rep(1,times=22)%*%t(c(0,10,0)), dna.tfc[,,2])
dna3<-abind(C%*%dna.tfc[,,1]%*%R, C%*%dna.tfc[,,2])
dna4<-abind(C%*%dna.tfc[,,1]%*%R, 
            procOPA(C%*%dna.tfc[,,1]%*%R ,C%*%dna.tfc[,,2], scale=TRUE)$Bhat)
#print(riemdist(C%*%dna.tfc[,,1]%*%R, C%*%dna.tfc[,,2]))


#shapes3d(dna2,col=cc,joinline=jj)

#shapes3d(dna4,col=cc,joinline=jj)

dnarot <- thin
for ( i in 1:50){
  theta<- -0.1*rnorm(1)
  phi<- -0.2*rnorm(1)
  rot1<- matrix( c(cos(theta),-sin(theta),0,sin(theta),cos(theta),0,0,0,1),3,3)
  rot2<- matrix( c(cos(phi),0,-sin(phi),0,1,0,sin(phi),0,cos(phi)),3,3)
  rot1<-t(rot1)
  ro2<-t(rot2)
  dnarot[,,i]<- C%*%(dnarot[,,i])%*%rot1%*%rot2
}

#Two plots - unaligned and Procrustes aligned
#without scaling

#shapes3d(dnarot,joinline=jj)
#shapes3d(procGPA(dnarot,scale=FALSE)$rotated,joinline=jj,col=3)
#ans<-procGPA(dnarot,scale=FALSE)
#pairs(cbind(ans$size,ans$scores[,1:3]),labels=c("size","PC1","PC2","PC3"))

#with scaling

#shapes3d(dnarot,joinline=jj)
#shapes3d(procGPA(dnarot,scale=TRUE)$rotated,joinline=jj,col=3)

#########################################################################################

## Note that we have different possible choices for Procrustes tangent coordinates. 

## Using partial Procrustes tangent coordinates: 

ans<-procGPA(dnarot,scale=TRUE,tangentcoords="partial")
ans$scores[,1]<-ans$scores[,1]*(-1)  #flip signs to match the book view
ans$scores[,3]<-ans$scores[,3]*(-1)  #flip signs to match the book view
pairs(cbind(ans$size,ans$scores[,1:3]),labels=c("size","PC1","PC2","PC3"))
ans$percent


#The actual plot seen in Figure 8.10 uses the Procrustes residuals  
#as approximate tangent coordinates. Here the choices of tangent coordinates are extremely similar. 
#Note the scaling of the scores is different, but the pairwise plots are extremely similar
#up to a common scale.

ans<-procGPA(dnarot,scale=TRUE,tangentcoords="residual")
pairs(cbind(ans$size,ans$scores[,1:3]),labels=c("size","PC1","PC2","PC3"))
ans$percent





