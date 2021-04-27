disp('Running MATLAB script file OODAfig15p1.m') ;
%
%    Makes Figure 15.1 of the OODA book,
%    Hidalgo Stamps data, Histogram binwidths
%
%    Copied from OODAbookChpNFigAStamps.m
%    in:        OODAbook\ChapterN
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\HidalgoStampsData' ;


if ipart == 0 ;    %  Read in and save data

  datfilename = '..\..\..\..\Research\GeneralData\stamps.mat' ;

  %  Load data from .mat file
  %
  load(datfilename) ;
      %  Loads column vector:
      %      data

  xlswrite([datafilestr '.xlsx'],data) ;


else ;    %  Make main graphic

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


  %  Create Binwidth plots
  %
  figure(1) ;
  clf ;

  subplot(2,2,1) ;  %  good looking two modes
    gridstart = (vaxdata(1) + mindata) / 2 ;
        %  Start grids halfway between left end and first data point
    bw = 0.013 ;
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
    vax = axisSM(vedges(1:nbin),vhts) ;
    axis([vax(1) vax(2) 0 vax(4)]) ;
    hold on ;
      text(vax(1) + texth * (vax(2) - vax(1)), ...
           0 + textv * vax(4),['binwidth = ' num2str(bw)]) ;
    hold off ;

  subplot(2,2,2) ;  %  good looking four modes
    gridstart = (vaxdata(1) + mindata) / 2 ;
        %  Start grids halfway between left end and first data point
    bw = 0.0063 ;
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
    vax = axisSM(vedges(1:nbin),vhts) ;
    axis([vax(1) vax(2) 0 vax(4)]) ;
    hold on ;
      text(vax(1) + texth * (vax(2) - vax(1)), ...
           0 + textv * vax(4),['binwidth = ' num2str(bw)]) ;
    hold off ;

  subplot(2,2,3) ;  %  good looking six modes
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
    vax = axisSM(vedges(1:nbin),vhts) ;
    axis([vax(1) vax(2) 0 vax(4)]) ;
    hold on ;
      text(vax(1) + texth * (vax(2) - vax(1)), ...
           0 + textv * vax(4),['binwidth = ' num2str(bw)]) ;
    hold off ;

  subplot(2,2,4) ;  %  good looking ten modes
    gridstart = (vaxdata(1) + mindata) / 2 ;
        %  Start grids halfway between left end and first data point
    bw = 0.00156 ;
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
    vax = axisSM(vedges(1:nbin),vhts) ;
    axis([vax(1) vax(2) 0 vax(4)]) ;
    hold on ;
      text(vax(1) + texth * (vax(2) - vax(1)), ...
           0 + textv * vax(4),['binwidth = ' num2str(bw)]) ;
    hold off ;




  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig15p1.png') ;


end ;

