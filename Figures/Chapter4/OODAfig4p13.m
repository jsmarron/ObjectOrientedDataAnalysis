disp('Running MATLAB script file OODAfig4p13.m') ;
%
%    Makes Figure 4.13 of the OODA book,
%    PCA scores of log data curves from 2011 Lung Cancer Data
%
%    Copied from OODAbookChpBFigL.m
%    in:        OODAbook\ChapterB
%

datafilestr = '..\..\DataSets\OverlappingClassesData' ;

n1 = 50 ;
n2 = 50 ;


%  Read in data
%
mdata = xlsread(datafilestr) ;

mcolor = [(ones(n1,1) * [1 0 0]); ...
          (ones(n2,1) * [0 0 1])] ;
markerstr = [] ;
for i = 1:n1 ;
  markerstr = strvcat(markerstr,'+') ;
end ;
for i = 1:n2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;


flagDWD = logical([ones(1,n1) zeros(1,n2)]) ;
vDWDdir = DWD2XQ(mdata(:,flagDWD),mdata(:,~flagDWD)) ;


%  Make main graphics
%
figure(1) ;
clf ;
labelcellstr = {{'DWD Scores'; 'OPC 1 Scores'; 'OPC 2 Scores'}} ;
paramstruct = struct('npcadiradd',-2, ...
                     'icolor',mcolor, ...
                     'markerstr',markerstr, ...
                     'isubpopkde',1, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,vDWDdir,paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p13.png') ;

