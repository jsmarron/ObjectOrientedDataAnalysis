disp('Running MATLAB script file OODAfig6p6.m') ;
%
%    Makes Figure 6.6 of the OODA book,
%    Two Class Gaussian Data
%    curvdat analysis, original
%
%    Copied from OODAbookChpFFigCToyHeatMapVsPCA.m
%    in:        OODAbook\ChapterF
%

datafilestr = '..\..\DataSets\TwoClassGaussianData' ;

n1 = 100 ;
n2 = 100 ;
d = 20000 ;

mcolor = ones(n1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(n2,1) * [1 0 1])] ;
markerstr = 'x' ;
for i = 2:n1 ;
  markerstr = strvcat(markerstr,'x') ;
end ;
for i = 1:n2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;
cmap = [[ones(30,1) (linspace(0,1,30)' * [1 1])]; ...
        [(linspace(1,0,30)' * [1 1]) ones(30,1)]] ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Make Part 2: PCA scatterplots
%
figure(2) ;
clf ;
labelcellstr = {{'PC1 scores' 'PC2 scores' 'PC3 scores'}} ;
paramstruct = struct('npcadiradd',3, ...
                     'icolor',mcolor, ...
                     'markerstr',markerstr, ...
                     'isubpopkde',1, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig6p6.png') ;



