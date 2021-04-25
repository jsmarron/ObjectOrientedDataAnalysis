disp('Running MATLAB script file OODAfig11p6.m') ;
%
%    Makes Figure 11.6 of the OODA book,
%    Donut 2-d Toy Data
%    Compares polynomial kernel methods
%
%    Copied from OODAbookChpJFigEDonutPolyEmbed.m
%    in:        OODAbook\ChapterJ
%
 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic

datafilestr = '..\..\DataSets\DonutData' ;

n = 100 ;
left = -4 ;
right = 4 ;
bottom = -4 ;
top = 4 ;


if ipart == 0 ;    %  Generate and save data

  %  set up parameters
  %
  seed = 29837409 ;
  randn('seed',seed) ;
  useed = 20938743 ;
  rand('seed',useed) ;


  %  generate data
  %
  data1 = 0.6 * randn(n,2) ;
  data2r = 2.5 + 0.5 * randn(n,1) ;
  data2theta = 2 * pi * rand(n,1) ;
  data2 = [(data2r .* cos(data2theta)) ...
               (data2r .* sin(data2theta))] ;


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


  for ipoly = 1:4 ;

    subplot(2,2,ipoly) ;

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
    if ipoly == 1 ;  %  x1,x2 only
      polytit = 'x_1,x_2 only' ;
      mdata1 = data1 ;
      mdata2 = data2 ;
      mmgrid = vmgrid ;
    elseif ipoly == 2 ;  %  x1,x2,x1^2
      polytit = 'x_1,x_2,x_1^2' ;
      mdata1 = [data1 data1(:,1).^2] ;
      mdata2 = [data2 data2(:,1).^2] ;
      mmgrid = [vmgrid vmgrid(:,1).^2] ;
    elseif ipoly == 3 ;  %  x1,x2,x2^2
      polytit = 'x_1,x_2,x_2^2' ;
      mdata1 = [data1 data1(:,2).^2] ;
      mdata2 = [data2 data2(:,2).^2] ;
      mmgrid = [vmgrid vmgrid(:,2).^2] ;
    elseif ipoly == 4 ;  %  x1,x2,x1^2,x2^2
      polytit = 'x_1,x_2,x_1^2,x_2^2' ;
      mdata1 = [data1 data1.^2] ;
      mdata2 = [data2 data2.^2] ;
      mmgrid = [vmgrid vmgrid.^2] ;

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

        title(['Polynomials: ' polytit],'Fontsize',12) ;

    hold off ;


  end ;    %  of ipoly loop


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig11p6.png') ;


end ;

