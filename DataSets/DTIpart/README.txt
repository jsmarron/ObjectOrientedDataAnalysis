Real DTI coronal slice data 
===========================

The data part50x20.csv are from 15 axial directions in directions15.txt 

The R program ../../Figures/Chapter8/OODAfig8p14-8p15.R 

estimates a single tensor by maximizing the posterior (MAP estimation) as
described in the SPIE paper. The DTs are parameterized to be positive semi-definite.

   Zhou, D., Dryden, I.L., Koloydenko, A. and Bai, L. (2008). A Bayesian method with 
   reparameterisation for diffusion tensor imaging. Proceedings, SPIE conference. Medical 
   Imaging 2008: Image Processing, Joseph M. Reinhardt, Josien P. W. Pluim, Editors, 69142J.

The data are the same as the real data in the Annals of Applied Statistics paper

    Dryden, I.L., Koloydenko, A. and Zhou, D. (2009). Non-Euclidean statistics for 
    covariance matrices, with applications to diffusion tensor imaging. Annals of Applied Statistics, 3, 1102–1123.

The program plots a grid of ellipsoids as it estimates the tensor at each location.
The grid of tensors is available at the end in the array DTgrid which is of size 50x20x6.
 
The six components of the tensor/covariance matrix are listed in the order
(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)
 
For further background 
 
      "White matter mapping using diffusion tensor MRI" Tench CR, Morgan PS, Wilson M, 
       Blumhardt LD. Magnetic Resonance in Medicine 47:967-972 (2002).
 
The MRI data were provided by Paul S.Morgan, PhD, University of Nottingham, and were acquired as part of a larger study with local research ethics committee approval.
