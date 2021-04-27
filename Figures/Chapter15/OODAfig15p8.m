disp('Running MATLAB script file OODAfig15p8.m') ;
%
%    Makes Figure 15.8 of the OODA book,
%    Bralower Fossils data, SiZer Analysis
%
%    Copied from OODAbookChpNFigDFossilsSiZer.m
%    in:        OODAbook\ChapterN
%

datafilestr = '..\..\DataSets\BralowerFossilsData' ;

%  Read in data
%
data = xlsread(datafilestr) ;

xstr = 'Age (mil. years)' ;
ystr = 'Strontium Ratio' ;


%  Set Common Quantities
%
disp(' ') ;
n = size(data,1)
vax = axisSM(data(:,1)) ; 
disp(' ') ;
hmin = 10^(-0.5) ;
hmax = 10^(1.3) ;
hh = 1.3 ;


%  Do SiZer Analysis
%
figure(1) ;
clf ;
paramstruct = struct('iout',1, ...
                     'imovie',0, ...
                     'simflag',1, ...
                     'xlabelstr',xstr, ...
                     'famoltitle','', ...
                     'sizertitle','', ...
                     'idatovlay',2, ...
                     'ndatovlay',2, ...
                     'iscreenwrite',1, ...
                     'minx',vax(1), ...
                     'maxx',vax(2), ...
                     'bpar',1, ...
                     'nfh',21, ...
                     'fhmin',hmin, ...
                     'fhmax',hmax, ...
                     'nsh',21, ...
                     'shmin',hmin, ...
                     'shmax',hmax, ...
                     'hhighlight',hh) ;
sizerSM(data,paramstruct) ;

%  Set nicer vertical tick marks on top (family) plot
%
subplot(2,1,1) ;
set(gca,'YTick',[0.70720 0.70730 0.70740 0.70750]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[10.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 9.5, 11.5]) ; 
print('-dpng','OODAfig15p8.png') ;



