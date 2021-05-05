#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 11.5 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the shapes library installing

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(shapes)
data(apes)
par(mfrow=c(1,2),cex=0.8)
ans<-procGPA(apes$x)
plot(ans$scores[,1],ans$scores[,2],pch=as.integer(apes$group),
        col=as.integer(apes$group),xlab="PC1",ylab="PC2",xlim=c(-25,30),ylim=c(-25,30))
legend(x=20,y=30,c("gor f","gor m","pan f","pan m","pongo f","pongo m"),pch=c(1,2,3,4,5,6),col=c(1,2,3,4,5,6))

test<-shapes.cva(apes$x,groups=apes$group,ncv=5)
plot(test,pch=as.integer(apes$group),col=as.integer(apes$group),xlab="CV1",ylab="CV2")
legend(x=4.5,y=-3,c("gor f","gor m","pan f","pan m","pongo f","pongo m"),pch=c(1,2,3,4,5,6),col=c(1,2,3,4,5,6))