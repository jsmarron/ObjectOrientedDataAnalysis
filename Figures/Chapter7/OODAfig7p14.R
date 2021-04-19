#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 7.14 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes, rgl library installing:  e.g. install.packages("shapes")

# Note that this produces 3D rgl views, which are then rotated by hand 
# to give the views in the Figure. 

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
library(rgl)


a2<- -.5*pi/8
a1<- -pi/8
ev1<-c ( 5 , .1 , .1)*0.5
ev2<-c ( .1 , 5 , .1) 


###########################################

Gamma<-matrix(c(cos(a1),-sin(a1),0,sin(a1),cos(a1),0,0,0,1),3,3)
Gamma2<-matrix(c(cos(a2),-sin(a2),0,sin(a2),cos(a2),0,0,0,1),3,3)


D1<- Gamma%*% diag(ev1) %*%t(Gamma)
D2<- Gamma2%*% diag(ev2) %*%t(Gamma2)


LD1<- Gamma%*% diag(log( ev1)  ) %*%t(Gamma)
LD2<- Gamma2%*% diag(log( ev2) ) %*%t(Gamma2)


nseries<-6
res1<-array(0,c(3,3,nseries))
res2<-array(0,c(3,3,nseries))
res3<-array(0,c(3,3,nseries))
res4<-array(0,c(3,3,nseries))
res5<-array(0,c(3,3,nseries))

for (iw in 1:(nseries-1) ){

f1<- nseries - iw
f2<- iw
nw<- f1+f2


Q1<-chol(D1)
Q2<-chol(D2)
Qdat<-array(0,c(4,3,nw))
H<-defh(3)

for (i in 1:f1){
Qdat[,,i]<-t(H)%*%t(Q1)
}
for (i in (f1+1):nw){
Qdat[,,i]<-t(H)%*%t(Q2)
}


Darray<-array( 0, c(3,3,2) )
Darray[,,1]<-D1
Darray[,,2]<-D2
M<-2
k<-3
########################################################################

weights<- c(f1/nw,f2/nw)

Dlog <- estLogEuclid(Darray,weights)
Driem <- estLogRiem2(Darray,weights)


######################################################################

#Procrustes size-and-shape
Q5star <- (f1 * t(Q1) + f2 * H%*% procOPA( t(H)%*%t(Q1) , t(H)%*%t(Q2) , scale=FALSE, 
reflect=TRUE)$Bhat)/nw
D5star<- Q5star%*%t(Q5star)  # transformation in the 2009 paper 
D5<-D5star


#Cholesky
Q6 <- (f1 * t(Q1) + f2 * t(Q2))/nw
D6<- Q6%*%t(Q6)


#Log-Euclidean
AA<- f1*LD1/nw + f2*LD2/nw 
ev<-eigen(AA,symmetric=TRUE)
D3<- ev$vectors%*%diag(exp(ev$values))%*%t(ev$vectors)


#Euclidean
D4 <- (f1*D1+f2*D2)/nw



res1[,,iw]<-D3
res2[,,iw]<-D4
res3[,,iw]<-D5
res4[,,iw]<-D6
res5[,,iw]<-Driem

rgl.clear()
}

res1[,,nseries]<-D2
res2[,,nseries]<-D2
res3[,,nseries]<-D2
res4[,,nseries]<-D2



#This figure was in Dryden, Koloydeno, Zhou (2009) AOAS

rgl.clear()

wire3d(ellipse3d( D1 ,centre = c(0,0,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D1 ,centre = c(0,3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D1 ,centre = c(0,-3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D1 ,centre = c(0,-6,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D1 ,centre = c(0,-9,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)

for (nw in 1:(nseries-1)){

wire3d(ellipse3d( res2[,,nw] ,centre = c(3*nw,3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=4)
wire3d(ellipse3d( res4[,,nw] ,centre = c(3*nw,0,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=6)
wire3d(ellipse3d( res3[,,nw] ,centre = c(3*nw,-3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=5)
wire3d(ellipse3d( res1[,,nw] ,centre = c(3*nw,-6,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( res5[,,nw] ,centre = c(3*nw,-9,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=7)
}


wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,0,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,-3,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,-6,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,-9,0), level=0.05),xlab=" ",ylab=" ",
zlab=" ",box=TRUE,axes=TRUE,col=2)


#=======================================


# This figures has four rows and is very similar to that in the book. 

rgl.clear()

wire3d(ellipse3d( D1 ,centre = c(0,0,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D1 ,centre = c(0,3,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D1 ,centre = c(0,-3,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D1 ,centre = c(0,-6,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)


for (nw in 1:(nseries-1)){
  
  
  #Euclidean
  wire3d(ellipse3d( res2[,,nw] ,centre = c(3*nw,3,0), level=0.05),xlab=" ",ylab=" ",
         zlab=" ",box=TRUE,axes=TRUE,col=3)
  #Log-Euclidean
  wire3d(ellipse3d( res1[,,nw] ,centre = c(3*nw,0,0), level=0.05),xlab=" ",ylab=" ",
         zlab=" ",box=TRUE,axes=TRUE,col=3)
  #Cholesky
  wire3d(ellipse3d( res4[,,nw] ,centre = c(3*nw,-3,0), level=0.05),xlab=" ",ylab=" ",
         zlab=" ",box=TRUE,axes=TRUE,col=3)
  #Procrustes
  wire3d(ellipse3d( res3[,,nw] ,centre = c(3*nw,-6,0), level=0.05),xlab=" ",ylab=" ",
         zlab=" ",box=TRUE,axes=TRUE,col=3)
  
}


wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,0,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,3,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,-3,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)
wire3d(ellipse3d( D2 ,centre = c(3*(nseries-1)+3,-6,0), level=0.05),xlab=" ",ylab=" ",
       zlab=" ",box=TRUE,axes=TRUE,col=3)


#=======================================







