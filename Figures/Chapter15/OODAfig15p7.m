disp('Running MATLAB script file OODAfig15p7.m') ;
%
%    Makes Figure 15.7 of the OODA book,
%    British Family Incomes data, SiZer Analysis
%
%    Copied from OODAbookChpNFigCIncomes.m
%    in:        OODAbook\ChapterN
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\BritishFamilyIncomesData' ;


if ipart == 0 ;    %  Read in and save data

  datfilename = '..\..\..\..\Research\GeneralData\incomes.mat' ;

  %  Load data from .mat file
  %
  load(datfilename) ;
      %  loads 7201 British Incomes data into column vector, data
      %  as well as xstr & ystr

  xstr
  ystr
      %  These screenwrites were used to set strings in part below

  xlswrite([datafilestr '.xlsx'],data) ;


else ;    %  Make main graphic

  %  Read in data
  %
  data = xlsread(datafilestr) ;

  xstr = 'Normalized Income' ;
  ystr = 'density' ;


  %  Set Common Quantities
  %
  disp(' ') ;
  n = length(data) ;
  mindata = min(data) ; 
  maxdata = max(data) ;
  upperend = 3  ;
  disp(['# data > upperend = ' num2str(sum(data > upperend))]) ;
  disp(' ') ;
  hmin = 10^(-2) ;
  hmax = 10^(0) ;
  hh = 10^(-1.1) ;


  %  Do SiZer Analysis
  %
  figure(1) ;
  clf ;
  paramstruct = struct('iout',1, ...
                       'imovie',0, ...
                       'simflag',1, ...
                       'xlabelstr','Family Income / Mean', ...
                       'famoltitle','', ...
                       'sizertitle','', ...
                       'idatovlay',2, ...
                       'ndatovlay',2, ...
                       'iscreenwrite',1, ...
                       'minx',0, ...
                       'maxx',upperend, ...
                       'bpar',1, ...
                       'nfh',21, ...
                       'fhmin',hmin, ...
                       'fhmax',hmax, ...
                       'nsh',21, ...
                       'shmin',hmin, ...
                       'shmax',hmax, ...
                       'hhighlight',hh) ;
  sizerSM(data,paramstruct) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[10.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 9.5, 11.5]) ; 
  print('-dpng','OODAfig15p7.png') ;


end ;

