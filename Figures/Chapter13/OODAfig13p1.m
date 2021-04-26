disp('Running MATLAB script file OODAfig13p1.m') ;
%
%    Makes Figure 13.1 of the OODA book,
%    DiProPerm of Two Class Gaussian data
%
%    Copied from OODAbookChpLFigAToyPCADiProPerm.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\TwoClassGaussianData' ;

n1 = 100 ;
n2 = 100 ;
d = 20000 ;


%  Read in data
%
mdata = xlsread(datafilestr) ;

mcolor = ones(n1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(n2,1) * [1 0 1])] ;
markerstr = 'x' ;
for i = 2:n1 ;
  markerstr = strvcat(markerstr,'x') ;
end ;
for i = 1:n2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;
cmap = [[ones(32,1) (linspace(0,1,32)' * [1 1])]; ...
        [(linspace(1,0,32)' * [1 1]) ones(32,1)]] ;

%  Run DiProPerm
%
figure(1) ;
clf ;
paramstruct = struct('idir',2, ...
                     'istat',2, ...
                     'icolor',[[0 1 0]; [1 0 1]], ...
                     'markerstr',['x';'o'], ...
                     'iscreenwrite',1) ;
DiProPermSM(mdata(:,(n1 + 1):(n1 + n2)),mdata(:,1:n1),paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p1.png') ;



