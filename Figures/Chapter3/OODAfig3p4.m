disp('Running MATLAB script file OODAfig3p4.m') ;
%
%    Makes Figure 3.4 of the OODA book,
%    Simple 2-d Toy Example
%    Decomposition of Variation 
%
%    Copied from OODAbookChpBFigD.m
%    in:        OODAbook\ChapterB
%


datafilestr = '..\..\DataSets\2dToyExampleData' ;
xgrid = [1; 2] ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Do preliminary calculations
%
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


figure(1) ;
clf ;

subplot(2,2,1) ;    %  make raw data plot
  ph1 = plot(xgrid,mdata,'kx', ...
             xgridw,mdataw,'k-', ...
             [[1; 1], [2; 2]], ...
             [[bottom; top], [bottom; top]],'k-') ;
    for ih = 1:n ;
      set(ph1(ih),'LineWidth',1.5) ;
      set(ph1(ih),'MarkerSize',6) ;
    end ;
    xlabel('Coordinate','FontSize',labfontsize) ;
    ylabel('Curve Height','FontSize',labfontsize) ;
    axis([0,d+1,bottom,top]) ;
    axis square ;
      tx = 0 + 0.1 * (d - 0) ;
      ty = bottom + 0.07 * (top - bottom) ;
      tstr = ['Raw Data Objects'] ;
      text(tx,ty,tstr,  ...
                'FontSize',labfontsize) ;

subplot(2,2,2) ;    %  make mean plot
  ph2 = plot([[1; 1], [2; 2]], ...
             [[bottom; top], [bottom; top]],'k-', ...
             xgrid,vmean,'g+', ...
             xgridw,vmeanw,'g-') ;
      set(ph2(3),'LineWidth',3) ;
      set(ph2(3),'MarkerSize',10) ;
      set(ph2(3),'Color',[0 0.7 0]) ;
      set(ph2(4),'LineWidth',2) ;
      set(ph2(4),'Color',[0 0.7 0]) ;
    xlabel('Coordinate','FontSize',labfontsize) ;
    ylabel('Curve Height','FontSize',labfontsize) ;
    axis([0,d+1,bottom,top]) ;
    axis square ;
      tx = 0 + 0.1 * (d - 0) ;
      ty = bottom + 0.07 * (top - bottom) ;
      tstr = ['Sample Mean'] ;
      text(tx,ty,tstr,  ...
                'FontSize',labfontsize) ;



minx1 = min(min([mmeanresid(1,:), 0])) ;
maxx1 = max(max([mmeanresid(1,:), 0])) ;
rangex1 = maxx1 - minx1 ;
minx1 = minx1 - 0.05 * rangex1 ;
maxx1 = maxx1 + 0.05 * rangex1 ;

minx2 = min(min([mmeanresid(2,:), 0])) ;
maxx2 = max(max([mmeanresid(2,:), 0])) ;
rangex2 = maxx2 - minx2 ;
minx2 = minx2 - 0.05 * rangex2 ;
maxx2 = maxx2 + 0.05 * rangex2 ;

bottom = min(minx1,minx2) ;
top = max(maxx1,maxx2) ;


mpc1line = meigvec(:,1) * mpc(1,:) ;
mpc1linew = [mpc1line(1,:); mpc1line(1,:); 
                  mpc1line(end,:); mpc1line(end,:)] ;
subplot(2,2,3) ;    %  make PC1 component plot
  ph3 = plot(xgrid,mpc1line,'m+', ...
             xgridw,mpc1linew,'m-', ...
             [[1; 1], [2; 2]], ...
             [[bottom; top], [bottom; top]],'k-') ;
    for ih = 1:n ;
      set(ph3(ih),'LineWidth',1.5) ;
      set(ph3(ih),'MarkerSize',7) ;
    end ;
    xlabel('Coordinate','FontSize',labfontsize) ;
    ylabel('Curve Height','FontSize',labfontsize) ;
    axis([0,d+1,bottom,top]) ;
    axis square ;
      tx = 0 + 0.1 * (d - 0) ;
      ty = bottom + 0.07 * (top - bottom) ;
      tstr = ['1st Mode of Variation'] ;
      text(tx,ty,tstr,  ...
                'FontSize',labfontsize) ;

mpc2line = meigvec(:,2) * mpc(2,:) ;
mpc2linew = [mpc2line(1,:); mpc2line(1,:); 
                  mpc2line(end,:); mpc2line(end,:)] ;
subplot(2,2,4) ;    %  make PC2 component plot
  ph4 = plot(xgrid,mpc2line,'c+', ...
             xgridw,mpc2linew,'c-', ...
             [[1; 1], [2; 2]], ...
             [[bottom; top], [bottom; top]],'k-') ;
    for ih = 1:n ;
      set(ph4(ih),'LineWidth',1.5) ;
      set(ph4(ih),'MarkerSize',7) ;
    end ;
    xlabel('Coordinate','FontSize',labfontsize) ;
    ylabel('Curve Height','FontSize',labfontsize) ;
    axis([0,d+1,bottom,top]) ;
    axis square ;
      tx = 0 + 0.1 * (d - 0) ;
      ty = bottom + 0.07 * (top - bottom) ;
      tstr = ['2nd Mode of Variation'] ;
      text(tx,ty,tstr,  ...
                'FontSize',labfontsize) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 11.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 10.5]) ; 
print('-dpng','OODAfig3p4.png') ;


