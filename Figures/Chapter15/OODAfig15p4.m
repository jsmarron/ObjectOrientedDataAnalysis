disp('Running MATLAB script file OODAfig15p4.m') ;
%
%    Makes Figure 15.4 of the OODA book,
%    Hidalgo Stamps data, Histo shifts and KDE
%
%    Copied from OODAbookChpNFigAStamps.m
%    in:        OODAbook\ChapterN
%

datafilestr = '..\..\DataSets\HidalgoStampsData' ;


%  Read in data
%
data = xlsread(datafilestr) ;


%  Set Common Quantities
%
n = length(data) ;     %  485
mindata = min(data) ;    %  0.060
maxdata = max(data) ;    %  0.131
vaxdata = axisSM(data) ;
vcolor = [0.6 0.6 0.6] ;    %  middle gray
texth = 0.42 ;
textv = 0.9 ;
shiftfac = 0.5 ;


figure(1) ;
clf ;


subplot(1,2,2) ;  %  shifted by bw / 2, two modes
  bw = 0.0049 ;
      %  binwidth
  gridstart = ((vaxdata(1) + mindata) / 2) + shiftfac * bw ;
      %  Start grids halfway between left end and first data point
  nbin = ceil((maxdata - gridstart) / bw) ;
      %  number of bins to go beyond max of data
  vedges = gridstart + (0:nbin) * bw ;
  vcts = histc(data',vedges) ; 
  vhts = (vcts / n) / bw ;
  for i = 1:(nbin - 1) ;
    patch([vedges(i) vedges(i) vedges(i + 1) vedges(i + 1) vedges(i)], ...
          [0 vhts(i) vhts(i) 0 0 ], vcolor) ;
  end ; 
  vax = axisSM(vedges(1:nbin),vhts) ;
  axis([(vax(1) - shiftfac * bw) vax(2) 0 vax(4)]) ;

  hold on ;
    h = 0.0016 ;
    paramstruct = struct('vh',h, ...
                         'vxgrid',[(vax(1) - shiftfac * bw) vax(2)], ...
                         'idatovlay',0, ...
                         'linewidth',2, ...
                         'linecolor','k') ;
    [kde,xgrid] = kdeSM(data,paramstruct) ;
    plot(xgrid,kde,'k-','LineWidth',2) ;
  hold off ;

subplot(1,2,1) ;  %  6 modes
  gridstart = (vaxdata(1) + mindata) / 2 ;
      %  Start grids halfway between left end and first data point
  bw = 0.0049 ;
      %  binwidth
  nbin = ceil((maxdata - gridstart) / bw) ;
      %  number of bins to go beyond max of data
  vedges = gridstart + (0:nbin) * bw ;
  vcts = histc(data',vedges) ; 
  vhts = (vcts / n) / bw ;
  for i = 1:(nbin - 1) ;
    patch([vedges(i) vedges(i) vedges(i + 1) vedges(i + 1) vedges(i)], ...
          [0 vhts(i) vhts(i) 0 0 ], vcolor) ;
  end ; 
  axis([(vax(1) - shiftfac * bw) vax(2) 0 vax(4)]) ;

  hold on ;
    plot(xgrid,kde,'k-','LineWidth',2) ;
  hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig15p4.png') ;



