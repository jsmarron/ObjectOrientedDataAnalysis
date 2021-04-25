disp('Running MATLAB script file OODAfig11p3.m') ;
%
%    Makes Figure 11.3 of the OODA book,
%    Simple Comparisons of MD, LDA, MDP
%        over increasing sample sizes
%
%    Copied from OODAbookChpJFigCHighDClass.m
%    in:        OODAbook\ChapterJ
%

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
vd = [10 40 200] ;
nd = length(vd) ;

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


%  Loop through dimensions
%
for id = 1:nd ;

  d = vd(id) ;

  mtraindat1id = [mtraindat1, (sig * randn(n1,(d - 1)))] ;
  mtraindat2id = [mtraindat2, (sig * randn(n2,(d - 1)))] ;
  mtraindatid = [mtraindat1id; mtraindat2id] ;
        %  Tack d-1 random columns onto base

  for idisc = 1:3 ;    %  loop through discrimination rules

    if idisc == 1 ;    %  MD

      discstr = 'MD' ;
      vmean1 = mean(mtraindat1id',2) ;
      vmean2 = mean(mtraindat2id',2) ;
      w = (vmean1 - vmean2) ;
      w = w / norm(w) ;
      w = w' ;
          %  normal vector to separating plane

    elseif idisc == 2 ;    %  FLD (previously called "proper FLD")
                           %  Later renamed LDA

      discstr = 'LDA' ;
      vmean1fld = mean(mtraindat1id',2) ;
      vmean2fld = mean(mtraindat2id',2) ;
      vmeanfld = mean([vmean1fld vmean2fld],2) ;
      mresid1 = mtraindat1id' - vec2matSM(vmean1fld,n1) ;
      mresid2 = mtraindat2id' - vec2matSM(vmean2fld,n2) ;
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

    elseif idisc == 3 ;    %  MDP (previously called "global covariance")

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

    end ;    %  of discriminator if-block

    %  Make graphic for this subplot
    %
    mt1w = mtraindat1id * w' ;
    mt2w = mtraindat2id * w' ;
          %  projection of data onto discrimination direction
    h1 = bwsjpiSM(mt1w,[left; right]) ;
    h2 = bwsjpiSM(mt2w,[left; right]) ;
    h = exp(mean(log([h1; h2]))) ;
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
    subplot(3,3,3 * (idisc - 1) + id) ;
    plot(kdexgrid,d1kde2,'r-', ...
         kdexgrid,d2kde2,'b-', ...
         [left; right],[0; 0],'m-','LineWidth',lwkde) ;
         axis([left,right,bottom2,top2]) ;
      hold on ;
         plot(mt1w,d1rhts2,'r+','MarkerSize',ms,'LineWidth',lw) ;
         plot(mt2w,d2rhts2,'bo','MarkerSize',ms,'LineWidth',lw) ;
         title([discstr ', d = ' num2str(d)]) ;
         text(left + 0.2 * (right - left), ...
              bottom2 + 0.2 * (top2 - bottom2), ...
              ['Angle = ' num2str(angle,2)]) ;
      hold off ;

  end ;    %  of loop through discrimination rules

end ;    %  of id loop through dimensions


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig11p3.png') ;



