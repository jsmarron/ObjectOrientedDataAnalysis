#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 8.14 and 8.15 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the rgl library installing:  install.packages("rgl")

# Note that this produces a 3D rgl view for Fig 8.14, which are then rotated by hand 
# to give the views in the Figure. 

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(rgl)
setwd("/Users/pmzild/OneDrive - The University of Nottingham/tex/OODA/OODA-Data-R-Figures")


x<-scan("./Data/DTIpart/directions15.txt")
k<-length(x)/3

#############################file
nx<-50
ny<-20
z<-scan("./Data/DTIpart/part50x20.csv",sep=",")
#####################################


y<-array(z,c(ny,16,nx))

par(mfrow=c(4,4))
for (i in 1:16){
image(t(y[,i,]))
}

n<-length(z)/(k+1)

g<-t(matrix(x,k,3))
Sdata<-matrix(0,k+1,n)

iobs<-0
for (ix in 1:nx){
for (iy in 1:ny){
iobs<-iobs+1
Sdata[,iobs]<-y[iy,,ix]
}
}


logl1 <-function(Q1){
logprior<-   -(1/(2*xi**2))*2*sum(diag((Q1-I3)%*%t(Q1-I3)))  # nb x2 
S<-rep(0,times=k)
ssq<-0
for (i in 1:k){
S[i]<-S0*exp(-b*t(g[,i]%*%Q1%*%t(Q1)%*%g[,i]))
ssq<- ssq + (y[i]-S[i])**2    
}
sig2<-ssq/k
logl<- -(k/2)*log(sig2) - (1/(2*sig2)*ssq) + logprior
logl
}


like1<-function(x){
Q1<-matrix(x[1:9],3,3)
out<- -logl1(Q1)
out
}


sigma1 <-function(Q1){
S<-rep(0,times=k)
ssq<-0
for (i in 1:k){
S[i]<-S0*exp(-b*t(g[,i]%*%Q1%*%t(Q1)%*%g[,i]))
ssq<- ssq + (y[i]-S[i])**2    
}
sig2<-ssq/k
sqrt(sig2)
}



FAmap<-function(lam){
lb<-mean(lam)
fa<-sqrt(3*((lam[1]-lb)**2+(lam[2]-lb)**2+(lam[3]-lb)**2)/sum(2*lam**2))
}


plottensor<-function(Dinv,g,y,S0,mu=c(0,0,0),icol){
k<-dim(g)[2]
wire3d(ellipse3d(Dinv,centre=mu,level=0.2),xlab=" ",ylab=" ",
zlab=" ",box=FALSE,axes=FALSE,col=icol)
#for (i in 1:k){
#lines3d(rbind(mu,mu+g[,i]*5*(y[i]/S0)),col=1)
#lines3d(rbind(mu,mu-g[,i]*5*(y[i]/S0)),col=1)
#}
}

library(shapes)

rhodist<-function(D1,D2){
a1<-t(H)%*%t(chol(D1))
a2<-t(H)%*%t(chol(D2))
fit<-procOPA(a1,a2,scale=TRUE,reflect=TRUE)$Bhat
dd<-(norm( a1 - fit ))
dd
}

H<-defh(3)

par(mfrow=c(1,1))
plot(c(0,1.2),c(0,1.2),type="n",xlab="FA",ylab="sin rho")


FAgrid<-matrix(0,nx,ny)
rhogrid<-matrix(0,nx,ny)
GAgrid<-matrix(0,nx,ny)
DTgrid<-array(0,c(nx,ny,6))


obs<-0
for (ix in 1:nx){
for (iy in 1:ny){
obs <- obs + 1

S0<-Sdata[1,obs]
y<-Sdata[2:(k+1),obs]
b<-1
xi<-1
I3<-diag(3)




## single tensor fit ######
x<-c(1,0,0,0,1,0,0,0,1)


ans<-nlm(like1,x,iterlim=200)
ans1<-ans


Q1<-matrix(ans$estimate[1:9],3,3)
Q1single<-Q1

print("FA")
FA<-FAmap(eigen(Q1%*%t(Q1))$values)
print(FA)
print("rho")
rho<-(rhodist(diag(3)/sqrt(3),Q1%*%t(Q1) ) )
print(rho)

ev<-eigen(Q1%*%t(Q1),symmetric=TRUE)

GA<-sqrt(sum( ( log(ev$values)-mean(log(ev$values)) ) **2))
print("GA")
print(GA)

points(FA,rho)
#points(FA,GA,pch=2)
#points(rho,GA,pch=3)


FAgrid[ix,iy]<-FA
rhogrid[ix,iy]<-rho
GAgrid[ix,iy]<-GA

print("sigma hat")
s1<-sigma1(Q1)
print(s1)





D1<-Q1single%*%t(Q1single)

# here is the estimated covariance matrix
DTgrid[ix,iy,1]<-D1[1,1]
DTgrid[ix,iy,2]<-D1[1,2]
DTgrid[ix,iy,3]<-D1[1,3]
DTgrid[ix,iy,4]<-D1[2,2]
DTgrid[ix,iy,5]<-D1[2,3]
DTgrid[ix,iy,6]<-D1[3,3]

D1<-D1/sum(diag(D1))
plottensor(D1*FA,g,y,S0,mu=c(ix,iy,0)*1,7)

}
}



palette(heat.colors(100))

par(mfrow=c(1,3))
image(FAgrid,col=palette(heat.colors(seq(0,.9,len=100))),axes=FALSE)
image(rhogrid,col=palette(heat.colors(seq(0,.9,len=100))),axes=FALSE)
image(GAgrid,col=palette(heat.colors(seq(0,.9,len=100))),axes=FALSE)





