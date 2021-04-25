disp('Running MATLAB script file OODAfig11p7.m') ;
%
%    Makes Figure 11.7 of the OODA book,
%    Checkerboard 2-d Toy Data
%    Compares polynomial & Gaussian kernel methods
%
%    Copied from OODAbookChpJFigFCheckerboard.m
%    in:        OODAbook\ChapterJ
%
 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic

datafilestr = '..\..\DataSets\CheckerboardData' ;

nblock = 25 ;
n = 8 * nblock ;
sig = 1/3 ;
left = -4 ;
right = 4 ;
bottom = -4 ;
top = 4 ;


if ipart == 0 ;    %  Generate and save data

  %  set up parameters
  %
  seed = 20943343 ;
  randn('seed',seed) ;

  %  generate data
  %
  data1 = sig * randn(8*nblock,2) ;
  data2 = sig * randn(8*nblock,2) ;
  vmux = [-3; 1; -1; 3; -3; 1; -1; 3] ;
  vmuy = [3; 3; 1; 1; -1; -1; -3; -3] ;
  mmu = kron([vmux,vmuy],ones(nblock,1)) ;
  data1 = mmu + data1 ;
  mmu = kron([-vmux,vmuy],ones(nblock,1)) ;
  data2 = mmu + data2 ;


  xlswrite([datafilestr '.xlsx'],data1,'data1') ;
  xlswrite([datafilestr '.xlsx'],data2,'data2') ;


else ;    %  Make main graphic

  %  Read in data
  %
  data1 = xlsread(datafilestr,'data1') ;
  data2 = xlsread(datafilestr,'data2') ;


  %  Make main graphic
  %
  figure(1) ;
  clf ;


  for ipoly = 1:2 ;

    subplot(1,2,ipoly) ;

    %  Construct matrix of locations at which to do discrimination
    %
    nxgrid = 60 ;
    nygrid = 60 ;
    ngrid = nxgrid * nygrid ;
    vxgrid = linspace(left,right,nxgrid) ;
          %  marginal x grid points (row vector)
    vygrid = linspace(bottom,top,nxgrid)' ;
          %  marginal y grid points (col vector)
    mxgrid = vec2matSM(vxgrid,nygrid) ;
    mygrid = vec2matSM(vygrid,nxgrid) ;
          %  full matrices of grid points
          %      note:  have updated these from original vec2mat to vec2matSM
    vmgrid = [reshape(mxgrid,ngrid,1) ...
                  reshape(mygrid,ngrid,1)] ;
          %  re-organize as long 2 column matrix

    %  Set up appropriate polynomials
    %
    if ipoly == 1 ;  %  iipoly = 6:  x_1,x_2,x_1^2,x_2^2,x_1^3,x_2^3
        polytit = 'Cubic Polynomials' ;
        mdata1 = [data1 data1.^2 data1.^3] ;
        mdata2 = [data2 data2.^2 data2.^3] ;
        mmgrid = [vmgrid vmgrid.^2 vmgrid.^3] ;
    elseif ipoly == 2 ;  %  iipoly = 7:  Gaussian kernels
        polytit = 'Gaussian Kernels' ;
        vcent = -3:3 ;
        vcentx = reshape(vec2matSM(vcent,7),1,49) ;
        vcenty = reshape(vec2matSM(vcent,7)',1,49) ;
        margxdata1 = vec2matSM(data1(:,1),49) - vec2matSM(vcentx,n) ;
        margydata1 = vec2matSM(data1(:,2),49) - vec2matSM(vcenty,n) ;
        margxdata2 = vec2matSM(data2(:,1),49) - vec2matSM(vcentx,n) ;
        margydata2 = vec2matSM(data2(:,2),49) - vec2matSM(vcenty,n) ;
        margxmgrid = vec2matSM(vmgrid(:,1),49) - vec2matSM(vcentx,ngrid) ;
        margymgrid = vec2matSM(vmgrid(:,2),49) - vec2matSM(vcenty,ngrid) ;
            %      note:  have updated these from original vec2mat to vec2matSM
        vargxdata1 = reshape(margxdata1,49*n,1) ;
        vargydata1 = reshape(margydata1,49*n,1) ;
        vargxdata2 = reshape(margxdata2,49*n,1) ;
        vargydata2 = reshape(margydata2,49*n,1) ;
        vargxmgrid = reshape(margxmgrid,49*ngrid,1) ;
        vargymgrid = reshape(margymgrid,49*ngrid,1) ;
        kerxdata1 = normpdf(vargxdata1,0,1) ;
        kerydata1 = normpdf(vargydata1,0,1) ;
        kerxdata2 = normpdf(vargxdata2,0,1) ;
        kerydata2 = normpdf(vargydata2,0,1) ;
        kerxmgrid = normpdf(vargxmgrid,0,1) ;
        kerymgrid = normpdf(vargymgrid,0,1) ;
        mdata1 = kerxdata1 .* kerydata1 ;
        mdata2 = kerxdata2 .* kerydata2 ;
        mmgrid = kerxmgrid .* kerymgrid ;
        mdata1 = reshape(mdata1,n,49) ;
        mdata2 = reshape(mdata2,n,49) ;
        mmgrid = reshape(mmgrid,ngrid,49) ;
    end ;    %  of ipoly if block

    md = size(mmgrid,2) ;

    %  Do common preliminary calculations
    %
    mdataall = [mdata1; mdata2] ;
          %  all data vectors, with rows as data vectors
    vclasslabels = [ones(n,1); -ones(n,1)] ;


    %  Compute FLD part
    %
    disctit = 'FLD' ;

    mdatafld = mdataall' ;
        %  since gppca wants data vectors as columns

    vmean1fld = mean(mdata1',2) ;
    vmean2fld = mean(mdata2',2) ;
    vmeanfld = mean([vmean1fld vmean2fld],2) ;

    mresid1 = mdata1' - vec2matSM(vmean1fld,n) ;
    mresid2 = mdata2' - vec2matSM(vmean2fld,n) ;
        %      note:  have updated these from original vec2mat to vec2matSM
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

    mdisc = (mmgrid - vec2matSM(vmeanfld',ngrid)) * fldv ;
        %  use dot product with fldvector as discriminator
        %      note:  have updated from original vec2mat to vec2matSM


    %  Set up color map
    %
    disccomap = [linspace(0,1,32)' ones(32,1) ones(32,1)] ;
    disccomap = [disccomap; [ones(32,1) ones(32,1) linspace(1,0,32)']] ;
    colormap(disccomap) ;


    %  choose maxcolor cutoff
    %
    flag1 = mdisc > 0 ;
    flag2 = mdisc < 0 ;
    nf1 = sum(flag1) ;
    nf2 = sum(flag2) ;
    if nf1 > 0 & nf2 > 0 ;
      colorcut = min(median(abs(mdisc(flag1))), ...
                     median(abs(mdisc(flag2)))) ;
    else ;
      colorcut = median(abs(mdisc)) ;
    end ;


    %  Make main graphics
    %
    mdisc = reshape(mdisc,nygrid,nxgrid) ;
          %  put grid of discrimination results 
          %  back into matrix form for plotting

    imgdisc = mdisc / colorcut ;
          %  rescale so colorcut maps to [-1,1]
    imgdisc = 32 + 32 * imgdisc ;
          %  rescale to [0,64]


    image(vygrid,-vxgrid,imgdisc) ;
      axis image ;
      axis off ;


    %  Add data and axes
    hold on ;
      plot(data1(:,1),-data1(:,2),'r+', ...
           data2(:,1),-data2(:,2),'bo', ...
           [[0;0], [bottom;top]],[[left;right], [0;0]],'w-', ...
                  'MarkerSize',5,'LineWidth',0.5) ;
           %  Note plotting is done in "matrix coordinates",
           %  not usual "Cartesian Coordinates"

        title(polytit,'Fontsize',12) ;

    hold off ;


  end ;    %  of ipoly loop


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 6.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 5.5]) ; 
  print('-dpng','OODAfig11p7.png') ;


end ;

