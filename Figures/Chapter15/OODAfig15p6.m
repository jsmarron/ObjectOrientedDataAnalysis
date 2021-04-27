disp('Running MATLAB script file OODAfig15p6.m') ;
%
%    Makes Figure 15.6 of the OODA book,
%    Bralower Fossils data, Local Linear Smooths
%
%    Copied from OODAbookChpNFigBFossils.m
%    in:        OODAbook\ChapterN
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\BralowerFossilsData' ;


if ipart == 0 ;    %  Read in and save data

  datfilename = '..\..\..\..\Research\GeneralData\fossils.mat' ;

  %  Load data from .mat file
  %
  load(datfilename) ;
      %  loads Bralower Fossils data into 106 x 2 matrix of data
      %  as well as xstr & ystr

  xstr
  ystr
      %  These screenwrites were used to set strings in part below

  xlswrite([datafilestr '.xlsx'],data) ;


else ;    %  Make main graphic

  %  Read in data
  %
  data = xlsread(datafilestr) ;

  xstr = 'Age (mil. years)' ;
  ystr = 'Strontium Ratio' ;


  %  Make three local linear smooths
  %
  figure(1) ;
  clf ;
  vh = [0.4 1.3 4] ;
  vaxx = axisSM(data(:,1)) ;
  vaxy = axisSM(data(:,2)) ;
  paramstruct = struct('vh',vh, ...
                       'xgrid',vaxx, ...
                       'ndataoverlay',2, ...
                       'dolcolor','k', ...
                       'linewidth',2, ...
                       'linecolor','', ...
                       'xlabelstr',xstr, ...
                       'ylabelstr',ystr, ...
                       'plotbottom',vaxy(1), ...
                       'plottop',vaxy(2)) ;
  nprSM(data,paramstruct) ;

  set(gca,'YTick',[0.70720 0.70730 0.70740 0.70750]) ;

  legend(['h = ' num2str(vh(1))],['h = ' num2str(vh(2))], ...
         ['h = ' num2str(vh(3))],'Data X_i', ...
         'Location','SouthWest') ;

  vchil = get(gca,'Children') ;
  set(vchil(1),'Marker','+') ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 7.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
  print('-dpng','OODAfig15p6.png') ;


end ;

