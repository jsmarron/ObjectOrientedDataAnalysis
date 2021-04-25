disp('Running MATLAB script file OODAfig11p12.m') ;
%
%    Makes Figure 11.12 of the OODA book,
%    50-d toy comparison of MDP, SVM and DWD
%
%    Copied from OODAbookChpJFigHDWDvSVM.m
%    in:        OODAbook\ChapterJ
%
%    This uses the Matlab t-SNE software of Laurens van der Maaten, 2010
%    Must be in the Matlab path


%  Set Common Quantities
left = -4 ;
right= 4 ;
bottom = -2 ;
top = 2 ;
ms = 6 ;
lw = 1 ;
lwkde = 1 ;

n1 = 20 ;
n2 = 20 ;
d = 50 ;

seed = 7543870734 ;
randn('state',seed) ;

mu0 = 2.2 ;
sig0 = 1 ;
sig = 1 ;


%  Generate Base Data
%
mtraindat1 = mu0 + sig0 * randn(n1,1) ;
mtraindat2 = -mu0 + sig0 * randn(n2,1) ;
mtraindat = [mtraindat1; mtraindat2] ;
vtrainclass = [ones(n1,1); -ones(n2,1)] ;
        %  class labels
rhts1 = rand(n1,1) ;
rhts2 = rand(n2,1) ;


%  Start graphics
%
figure(1) ;
clf ;



mtraindat1id = [mtraindat1, (sig * randn(n1,(d - 1)))] ;
mtraindat2id = [mtraindat2, (sig * randn(n2,(d - 1)))] ;
mtraindatid = [mtraindat1id; mtraindat2id] ;
      %  Tack d-1 random columns onto base

for idisc = 1:4 ;    %  loop through discrimination rules

  if idisc == 1 ;    %  Optimal direction

    discstr = 'Optimal' ;
    w = [1 zeros(1,d - 1)] ;
        %  optimal projection vector

  elseif idisc == 2 ;    %  MDP (previously called "global covariance")

    discstr = 'MDP' ;
    vmean1fld = mean(mtraindat1id',2) ;
    vmean2fld = mean(mtraindat2id',2) ;
    vmeanfld = mean([vmean1fld vmean2fld],2) ;
    mresid1 = mtraindat1id' - vec2matSM(vmeanfld,n1) ;
    mresid2 = mtraindat2id' - vec2matSM(vmeanfld,n2) ;
    mresid = [mresid1 mresid2] ;
    mcov = cov(mresid') ;
        %  Get covariance matrix, transpose, since want 
        %               "coordinates as variables"
    mcovinv = pinv(mcov) ;
        %  pseudo-inverse
    fldv = mcovinv * (vmean1fld - vmean2fld) ;
        % Fisher Linear Discriminant Vector
    fldv = fldv / norm(fldv) ;
        %  make it a unit vector
    w = fldv' ;
        %  normal vector to separating plane

  elseif idisc == 3 ;    %  SVM

    discstr = 'SVM' ;
    dirvec = SVM1SM(mtraindat1id',mtraindat2id') ;
    w = dirvec' ;

  elseif idisc == 4 ;    %  DWD
  
    discstr = 'DWD' ;
    dirvec = DWD2XQ(mtraindat1id',mtraindat2id') ;
    w = dirvec' ;

  end ;    %  of discriminator if-block

  %  Make graphic for this subplot
  %
  mt1w = mtraindat1id * w' ;
  mt2w = mtraindat2id * w' ;
        %  projection of data onto discrimination direction
  h1 = bwsjpiSM(mt1w,[left; right]) ;
  h2 = bwsjpiSM(mt2w,[left; right]) ;
  h = exp(mean(log([h1; h2]))) ;
  if idisc == 4 ;
    h = 1.5 * h ;    %  better visual impression
  end ;
    paramstruct = struct('vxgrid',[left; right], ...
                         'vh',h) ;
  [d1kde2,kdexgrid] = kdeSM(mt1w,paramstruct) ;
  [d2kde2,kdexgrid] = kdeSM(mt2w,paramstruct) ;
  top2 = max([d1kde2; d2kde2]) ;
  bottom2 = -0.05 * top2 ;
  top2 = 1.05 * top2 ;
  d1rhts2 = bottom2 + (.7 + .1 * rhts1) * (top2 - bottom2) ;
  d2rhts2 = bottom2 + (.5 + .1 * rhts2) * (top2 - bottom2) ;
            %  random heights

  angle = acosd(w(1)) ;
      %  arc cos in degerees of inner product of w with optimal e_1
  subplot(2,2,idisc) ;
  plot(kdexgrid,d1kde2,'r-', ...
       kdexgrid,d2kde2,'b-', ...
       [left; right],[0; 0],'m-','LineWidth',lwkde) ;
       axis([left,right,bottom2,top2]) ;
    hold on ;
       plot(mt1w,d1rhts2,'r+','MarkerSize',ms,'LineWidth',lw) ;
       plot(mt2w,d2rhts2,'bo','MarkerSize',ms,'LineWidth',lw) ;
       title(discstr) ;
       text(left + 0.2 * (right - left), ...
            bottom2 + 0.2 * (top2 - bottom2), ...
            ['Angle = ' num2str(angle,2)]) ;
    hold off ;

end ;    %  of loop through discrimination rules


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig11p12.png') ;



