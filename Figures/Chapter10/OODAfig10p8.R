#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# R code to reproduce Figure 10.8 from the book by 
# J.S. Marron and Ian L. Dryden on Object Oriented Data Analysis

# Requires the network and GGally libraries installing

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

library(network)
library(GGally)

words<-c("it","was","the","best","worst","of","times")
GL<-matrix(c( 3,-2,0,0,0,0,-1,
              -2,4,-2,0,0,0,0,
              0,-2,4,-1,-1,0,0,
              0,0,-1,2,0,-1,0,
              0,0,-1,0,2,-1,0,
              0,0,0,-1,-1,4,-2,
              -1,0,0,0,0,-2,3),7,7)

A<-  -GL + diag(diag(GL)) 

ggn<-network(A,ignore.eval=FALSE,names.eval="weights")
set.seed(3)
plot(ggnet2(ggn,edge.alpha=0.5,label=words,edge.size="weights",color="pink"))


