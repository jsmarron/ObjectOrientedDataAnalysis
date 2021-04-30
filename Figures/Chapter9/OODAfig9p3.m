disp('Running MATLAB script file OODAfig9p3.m') ;
%
%    Makes Figure 9.3 of the OODA book,
%    Shifted Betas - PCA scores plot - harmonics
%
%    Copied from OODAbookChpHFigBToyBadScores.m
%    in:        OODAbook\ChapterH
%


datafilestr = '..\..\DataSets\ShiftedBetasData' ;

d = 1001 ;
      %  dimension of each data curve
xgrid = linspace(0,1,d)' ;
n = 29 ;
      %  number of data curves
mxgrid = xgrid * ones(1,n) ;


%  Read in data
%
mfi = xlsread(datafilestr) ;


%  Do scatplotSM analysis
%
figure(2) ;
clf ;
labelcellstr = {{'PC1 Scores'; 'PC2 Scores'; 'PC3 Scores'; 'PC4 Scores'}} ;
paramstruct = struct('npcadiradd',4, ...
                     'icolor',2, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mfi,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig9p3.png') ;


