Real DTI coronal slice data 

Instructions. You'll need R and the `shapes' and `rgl' packages.

Within R just type
 
source("realdata-ild-singletensor.r")
 
and it reads in the data (from 15 axial directions) and then estimates
a single tensor by maximizing the posterior (MAP estimation) as
described in the SPIE paper. The DTs are parameterized to be positive semi-definite.

   Zhou, D., Dryden, I.L., Koloydenko, A. and Bai, L. (2008). A Bayesian method with 
   reparameterisation for diffusion tensor imaging. Proceedings, SPIE conference. Medical 
   Imaging 2008: Image Processing, Joseph M. Reinhardt, Josien P. W. Pluim, Editors, 69142J.

The data are the same as the real data in the Annals of Applied Statistics paper

    Dryden, I.L., Koloydenko, A. and Zhou, D. (2009). Non-Euclidean statistics for 
    covariance matrices, with applications to diffusion tensor imaging. Annals of Applied #Statistics, 3, 1102–1123.

The program plots a grid of ellipsoids as it estimates the tensor at each location 
(takes a few minutes).
The grid of tensors is available at the end in the array DTgrid which is of size 50x20x6.
 
The six components of the tensor/covariance matrix are listed in the order
(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)
 
Please also give a reference to Paul Morgan (University of Nottingham) 
if you decide to use it in a paper, e.g. 
 
      "White matter mapping using diffusion tensor MRI" Tench CR, Morgan PS, Wilson M, 
       Blumhardt LD. Magnetic Resonance in Medicine 47:967-972 (2002).
 
and one should add in an acknowledgement too, such as 

    "The MRI data were provided by Paul S.Morgan, PhD, University of Nottingham, and were
     acquired as part of a larger study with local research ethics committee approval".

Thanks! 
Ian Dryden, University of Nottingham, 2017
