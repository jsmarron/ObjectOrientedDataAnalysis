#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 18.2 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#install RSDA package version 2.0 (old) and place the installed library 
#folder in the working directory and call it RSDA

#call library RSDA (version 2.0)

library("RSDA",lib.loc=".")
data(lynne2)
x<-lynne2
print(x)
sym.mean(sym.var(x,1),method='interval')
sym.mean(sym.var(x,2),method='interval')
sym.mean(sym.var(x,3),method='interval')
par(mfrow=c(3,3))
interval.histogram.plot(x = x[,1],n.bins=20,main=x$sym.var.names[1])
sym.scatterplot(x[,2],x[,1])
sym.scatterplot(x[,3],x[,1])
sym.scatterplot(x[,1],x[,2])
interval.histogram.plot(x = x[,2],n.bins=20,main=x$sym.var.names[2])
sym.scatterplot(x[,3],x[,2])
sym.scatterplot(x[,1],x[,3])
sym.scatterplot(x[,2],x[,3])
interval.histogram.plot(x = x[,3],n.bins=20,main=x$sym.var.names[3])
