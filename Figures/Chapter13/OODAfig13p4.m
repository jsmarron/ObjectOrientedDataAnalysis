disp('Running MATLAB script file OODAfig13p4.m') ;
%
%    Makes Figure 13.4 of the OODA book,
%    Toy example illustrating when DiProPerm not appropriate
%
%    Copied from OODAbookChpLFigDNotDiProPerm.m
%    in:        OODAbook\ChapterL
%


%  Generate Data
%
n = 100 ;
d = 2 ;
rng(36502061) ; 
mdata = randn(d,n) ;


%  Do Sigclust2MeansFast Clustering
%
paramstruct = struct('ioutplot',0) ;
[BestClass, bestCI] = SigClust2meanFastSM(mdata,paramstruct) ;
bestCI


%  Compute SigClust
%
figure(1) ;
clf ;
paramstruct = struct('vclass',BestClass, ...
                     'iCovEst',2, ...
                     'iBGSDdiagplot',0, ...
                     'iCovEdiagplot',0, ...
                     'ipValplot',0, ...
                     'pValsavestr',['SigClustToySigClust'], ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdata,paramstruct) ;


%  Compute DiProPerm
%
figure(1) ;
clf ;
paramstruct = struct('idir',2, ...
                     'istat',2, ...
                     'markerstr',['+';'x'], ...
                     'iscreenwrite',1) ;
DiProPermSM(mdata(:,BestClass == 1),mdata(:,BestClass == 2),paramstruct) ;


%  Visualize Cluster result
%
subplot(2,2,4) ;
cla ;
plot(mdata(1,BestClass == 1),mdata(2,BestClass == 1),'r+') ;
vax = axisSM(mdata(1,:),mdata(2,:)) ;
axis(vax) ;
hold on ;
  plot(mdata(1,BestClass == 2),mdata(2,BestClass == 2),'bx') ;
  text(vax(1) + 0.1 * (vax(2) - vax(1)), ...
       vax(3) + 0.1 * (vax(4) - vax(3)), ...
       ['SigClust p-value = ' num2str(pval)]) ;
hold off ;
axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p4.png') ;



