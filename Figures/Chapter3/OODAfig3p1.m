disp('Running MATLAB script file OODAfig3p1.m') ;
%
%    Makes Figure 3.1 of the OODA book,
%    Simple 2-d Toy Example
%    Raw Data and Mean 
%
%    Copied from OODAbookChpBFigA.m
%    in:        OODAbook\ChapterB
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\2dToyExampleData' ;
xgrid = [1; 2] ;


if ipart == 0 ;    %  Generate and save data

  d = 2 ;
  n = 12 ;
  mu = [3.3; 0.6] ;
  msig = [0.08 0; 0 0.08] ;
  randn('state',75029743095) ;
  mz = randn(d,n) ;
  mdata = sqrtm(msig) * mz + vec2matSM(mu,n) ;

  mu = [2.5; 3.8] ;
  msig = [0.05 0; 0 0.05] ;
  mz = randn(d,n) ;
  mdata = [mdata (sqrtm(msig) * mz + vec2matSM(mu,n))] ;

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;

  d = size(mdata,1) ;
      %  dimension of each data curve
  n = size(mdata,2) ;
      %  number of data curves

  %  Do main PCA calculation
  %
  paramstruct = struct('viout',ones(10,1),...
                       'iscreenwrite',1) ;
  outstruct = pcaSM(mdata,paramstruct) ;

  %  Unpack useful quantities
  %
  veigval = getfield(outstruct,'veigval') ;
  meigvec = getfield(outstruct,'meigvec') ;
  vmean = getfield(outstruct,'vmean') ;
  mmeanresid = getfield(outstruct,'mmeanresid') ;
  mpc = getfield(outstruct,'mpc') ;
  a3proj = getfield(outstruct,'a3proj') ;
  sstot = getfield(outstruct,'sstot') ;
  ssmresid = getfield(outstruct,'ssmresid') ;
  vpropSSmr = getfield(outstruct,'vpropSSmr') ;
  vpropSSpr = getfield(outstruct,'vpropSSpr') ;

  %  Do SVD
  %
  [mcolev,ms,mrowev] = svd(mdata) ;
        %  [U,S,V] = SVD(X) produces a diagonal matrix S, of the same 
        %  dimension as X and with nonnegative diagonal elements in
        %  decreasing order, and unitary matrices U and V so that
        %  X = U*S*V'.
  vs = diag(ms) ;

  mcomp1 = mcolev(:,1) * vs(1) * mrowev(:,1)' ;
  mcomp2 = mcolev(:,2) * vs(2) * mrowev(:,2)' ;


  %  Preliminary graphics quantities
  %
  titfontsize = 12 ;
  labfontsize = 10 ;

  mdataw = [mdata(1,:); mdata(1,:); mdata(end,:); mdata(end,:)] ;
      %  Wide version of data, where first and last rows are repeated,
      %       to add "flat parts" at either end
  xgridw = [0; xgrid; 3] ;
      %  Corresponding horizontal coordinates
  vmeanw = [vmean(1); vmean(1); vmean(end); vmean(end)] ;
  mmeanresidw = [mmeanresid(1,:); mmeanresid(1,:); ...
                      mmeanresid(end,:); mmeanresid(end,:)] ; 
  mcomp1w = [mcomp1(1,:); mcomp1(1,:); mcomp1(end,:); mcomp1(end,:)] ;
  mcomp2w = [mcomp2(1,:); mcomp2(1,:); mcomp2(end,:); mcomp2(end,:)] ;


  minx1 = min(min([mdata(1,:), 0])) ;
  maxx1 = max(max([mdata(1,:), 0])) ;
  rangex1 = maxx1 - minx1 ;
  minx1 = minx1 - 0.05 * rangex1 ;
  maxx1 = maxx1 + 0.05 * rangex1 ;

  minx2 = min(min([mdata(2,:), 0])) ;
  maxx2 = max(max([mdata(2,:), 0])) ;
  rangex2 = maxx2 - minx2 ;
  minx2 = minx2 - 0.05 * rangex2 ;
  maxx2 = maxx2 + 0.05 * rangex2 ;

  bottom = min(minx1,minx2) ;
  top = max(maxx1,maxx2) ;


  %  Make Main Graphics
  %
  figure(1) ;
  clf ;

  subplot(1,2,1) ;    %  make line plot
    xgrid = (1:d)' ;
    ph2 = plot(xgrid,mdata,'kx', ...
               xgridw,mdataw,'k-', ...
               [[1; 1], [2; 2]], ...
               [[bottom; top], [bottom; top]],'k-', ...
               xgrid,vmean,'g+', ...
               xgridw,vmeanw,'g-') ;
      for ih = 1:n ;
        set(ph2(ih),'LineWidth',1.5) ;
        set(ph2(ih),'MarkerSize',6) ;
      end ;
      set(ph2(2*n+3),'LineWidth',3) ; 
      set(ph2(2*n+3),'MarkerSize',10) ;
      set(ph2(2*n+3),'Color',[0 0.7 0]) ;
      set(ph2(2*n+4),'LineWidth',2) ;
      set(ph2(2*n+4),'Color',[0 0.7 0]) ;
  %    title(['Raw ' datatitstr],'FontSize',titfontsize) ;
      xlabel('Coordinate','FontSize',labfontsize) ;
      ylabel('Curve Height','FontSize',labfontsize) ;
      axis([0,d+1,bottom,top]) ;
      axis square ;
        tx = 0 + 0.1 * (d - 0) ;
        ty = bottom + 0.07 * (top - bottom) ;
        tstr = ['Object Space View' ' n = ' num2str(n)] ;
        text(tx,ty,tstr,  ...
                  'FontSize',labfontsize) ;

  subplot(1,2,2) ;    %  make point cloud plot
    ph1 = plot(mdata(1,:),mdata(2,:),'ko', ...
               [[0; 0], [minx1; maxx1]], ...
               [[minx2; maxx2], [0; 0]],'k-', ...
               vmean(1),vmean(2),'g+') ;
      set(ph1(1),'LineWidth',1.5) ;
      set(ph1(1),'MarkerSize',4) ;
      set(ph1(4),'LineWidth',3) ;
      set(ph1(4),'MarkerSize',10) ;
      set(ph1(4),'Color',[0 0.7 0]) ;
      axis([minx1, maxx1, minx2, maxx2]) ;
      axis square ;
      xlabel('x_1','FontSize',labfontsize) ;
      ylabel('x_2','FontSize',labfontsize) ;
        tx = minx1 + 0.1 * (maxx1 - minx1) ;
        ty = minx2 + 0.07 * (maxx2 - minx2) ;
        text(tx,ty,'Feature Space View',  ...
                  'FontSize',labfontsize) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
  print('-dpng','OODAfig3p1.png') ;


 end ;
