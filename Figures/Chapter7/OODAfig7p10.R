#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 7.10 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing:  install.packages("shapes")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



library(shapes)
par(mfrow=c(1,2))
plotshapes(digit3.dat[,,1],col=2)
lines(digit3.dat[,,1],col=2)
points(digit3.dat[,,2],col=4)
lines(digit3.dat[,,2],col=4)
ans2<-procOPA(digit3.dat[,,1],digit3.dat[,,2])
plotshapes(ans2$Ahat,col=2)
lines(ans2$Ahat,col=2)
points(ans2$Bhat,col=4)
lines(ans2$Bhat,col=4)


par(mfrow=c(1,2))
n1<-3
n2<-10
th<- -0.6
C<-t(defh(12))%*%defh(12)
A <- 0.8*C%*%digit3.dat[,,n1]%*%matrix( c(cos(th), -sin(th), sin(th), cos(th)),2,2)+cbind(rep(25,times=13),rep(-25,times=13))
B<-digit3.dat[,,n2]



plotshapes(B,col=2)
lines(B,col=2)
points(A,col=4)
lines(A,col=4)
ans2<-procOPA(B,A)
plotshapes(ans2$Ahat,col=2)
lines(ans2$Ahat,col=2)
points(ans2$Bhat,col=4)
lines(ans2$Bhat,col=4)


print(riemdist(A,B))
print(sin(riemdist(A,B)))
print(2*sin(riemdist(A,B)/2))


