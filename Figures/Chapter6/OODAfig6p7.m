disp('Running MATLAB script file OODAfig6p7.m') ;
%
%    Makes Figure 6.7 of the OODA book,
%    Two Clusters Data
%    curvdat analysis, original
%
%    Copied from OODAbookChpFFigAToyHeatMapCluster.m
%    in:        OODAbook\ChapterF
%
%
%    Note:  Data are regenerated, instead of reading from TwoClustersData.xlsx, 
%           to keep ordering for colors.
%


%  Set preliminaries
%
rng(34659896) ;
    %  Seed for random number generators
mdata = 12 * rand(50,50) ;
mdata(1:25,:) = mdata(1:25,:) + 4 ;
mdata(:,1:25) = mdata(:,1:25) + 4 ;
perm1 = randperm(50) ;
perm2 = randperm(50) ;
mdata = mdata(perm1',perm2) ;

mcolor = ones(25,1) * [0 0.6 0.6] ;
mcolor = [mcolor; (ones(25,1) * [0.9 0.6 0])] ;
mcolor = mcolor(perm2',:) ;

markerstr = 's' ;
for i = 1:24 ;
  markerstr = strvcat(markerstr,'s') ; 
end ;
for i = 1:25 ;
  markerstr = strvcat(markerstr,'x') ; 
end ;
markerstr = markerstr(perm2') ;

vcolindex = ClusterOrderSM(mdata) ;
vrowindex = ClusterOrderSM(mdata') ;

figure(1) ;
clf ;
paramstruct = struct('vipcplot',[0 1], ...
                     'vicolplot',[1 2 4], ...
                     'nevcompute',25, ...
                     'icolor',mcolor(vcolindex,:), ...
                     'isubpopkde',1, ...
                     'markerstr',markerstr(vcolindex), ...
                     'iscreenwrite',1) ;
curvdatSM(mdata(vrowindex,vcolindex),paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 8.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 7.5]) ; 
print('-dpng','OODAfig6p7.png') ;



