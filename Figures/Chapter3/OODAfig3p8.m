disp('Running MATLAB script file OODAfig3p8.m') ;
%
%    Makes Figure 3.8 of the OODA book,
%    PCA of quantile representation
%
%    Copied from OODAbookChpBFigVW.m
%    in:        OODAbook\ChapterB
%


%    Set Preliminaries
%
n = 100 ;
d = 401 ;
rng(46554387) ;
xgrid = linspace(0,400,d)' ;
vxcol = rand(1,n) ;
vmu = 100 + 200 * vxcol ;
vycol = rand(1,n) ;
vsig = 10 + 40 * vycol ;
mden = normpdf(vec2matSM(xgrid,n), ...
               vec2matSM(vmu,d), ...
               vec2matSM(vsig,d)) ;
pgrid = linspace(1 / d, (d - 1) / d,d)' ;
mquant = norminv(vec2matSM(pgrid,n), ...
               vec2matSM(vmu,d), ...
               vec2matSM(vsig,d)) ;
mcolor = vxcol' * [0 0 1] + vycol' * [1 0 0] ;

%  Make Graphics
%
figure(1) ;
clf ;
paramstruct = struct('vipcplot',[0 1 2], ...
                     'vicolplot',[1 4], ...
                     'icolor',mcolor, ...
                     'iscreenwrite',1) ;
curvdatSM(mquant,paramstruct) ;
subplot(3,2,2) ;
set(get(gca,'Title'),'String','Scree Plot')


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[10.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 9.5, 11.5]) ; 
print('-dpng','OODAfig3p8.png') ;


