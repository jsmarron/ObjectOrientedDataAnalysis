disp('Running MATLAB script file OODAfig13p2.m') ;
%
%    Makes Figure 13.2 of the OODA book,
%    DiProPerm of Overlapping Classes data
%
%    Copied from OODAbookChpLFigBToyDWDDiProPerm.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\OverlappingClassesData' ;


d = 1000 ;
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


%  Run DiProPerm
%
figure(1) ;
clf ;
paramstruct = struct('idir',1, ...
                     'istat',2, ...
                     'ishowperm',0, ...
                     'icolor',1, ...
                     'markerstr',['+';'o'], ...
                     'iscreenwrite',1) ;
DiProPermSM(mdata(:,1:n1),mdata(:,(n1 + 1):(n1 + n2)),paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig13p2.png') ;



