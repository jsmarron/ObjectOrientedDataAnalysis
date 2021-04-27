disp('Running MATLAB script file OODAfig15p3.m') ;
%
%    Makes Figure 15.3 of the OODA book,
%    Hidalgo Stamps data, KDE Intro
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

%  Randomly Sort Data for better jitter plot visualization
%
rng('default') ;
rng(40947590) ;
    %  set seed of random generator
vind = randperm(n) ;
sdata = data(vind) ;
    %  seeded random permutation of data

hSJPI = bwsjpiSM(sdata) ;
disp(['HSJPI = ' num2str(hSJPI)]) ;

vh = [0.0006, 0.0016, 0.005] ;
paramstruct = struct('vh',vh, ...
                     'vxgrid',1, ...
                     'dolcolor','k', ...
                     'dolmarkerstr','.', ...
                     'linewidth',2, ...
                     'linecolor','', ...
                     'xlabelstr','Stamp Thickness (mm)', ...
                     'iplot',1) ;
[kde,xgrid] = kdeSM(sdata,paramstruct) ;

legend('Data X_i',['h = ' num2str(vh(1))],['h = ' num2str(vh(2))],['h = ' num2str(vh(3))]) ;

hold on ;    %  overlay kernel functions
  mu = 0.078 ;
  scafact = 0.016 ;
  mker = [normpdf(xgrid,mu,vh(1)) normpdf(xgrid,mu,vh(2)) normpdf(xgrid,mu,vh(3))] ;
  plot(xgrid,scafact * mker,'Linewidth',2) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig15p3.png') ;



