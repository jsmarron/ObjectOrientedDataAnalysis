disp('Running MATLAB script file OODAfig13p7.m') ;
%
%    Makes Figure 13.7 of the OODA book,
%    Four Cluster data, SigClust on long green cluster and red outliers
%
%    Copied from OODAbookChpLFigGSigClustLongOut.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\FourClusterData' ;

nc1 = 60 ;
nc2 = 30 ;
nc3 = 30 ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Make main graphic
%
figure(1) ;
clf ;

n = size(mdata,2) ;


mcolor = ones(nc1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(nc2,1) * [0 0 1])] ;
mcolor = [mcolor; (ones(nc3,1) * [0 1 1])] ;
mcolor = [mcolor; [1; 1] * [1 0 0]] ;

markerstr = [] ;
for i = 1:nc1 ;
  markerstr = strvcat(markerstr,'+') ;
end ;
for i = 1:nc2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;
for i = 1:nc3 ;
  markerstr = strvcat(markerstr,'s') ;
end ;
markerstr = strvcat(markerstr,'x') ;
markerstr = strvcat(markerstr,'x') ;

left = 0 ;
right = 1 ;
bottom = -1 ; 
top = 1 ;


figure(1) ;
clf ;
mdatarg = [mdata(:,1:nc1) mdata(:,(n-1):n)] ;
nrg = size(mdatarg,2) ;
vflagg = logical([ones(1,nc1) zeros(1,2)]) ;
CI = ClustIndSM(mdatarg,vflagg,~vflagg) ;
paramstruct = struct('npc',2, ...
                     'iscreenwrite',1, ...
                     'viout',[1 1 1]) ;
outstruct = pcaSM(mdatarg,paramstruct) ;
veigval = getfield(outstruct,'veigval') ;
meigvec = getfield(outstruct,'meigvec') ;
vmean = getfield(outstruct,'vmean') ;
ecovmat = meigvec * diag(veigval) * meigvec' ;
msim = vmean * ones(1,nrg) + sqrtm(ecovmat) * randn(2,nrg) ;
[BestClass, simCI] = SigClust2meanFastSM(msim) ;

vclass = [ones(1,nc1) 2 2] ;
paramstruct = struct('vclass',vclass, ...
                     'iCovEst',2, ...
                     'iscreenwrite',1) ;
SigClustSM(mdatarg,paramstruct) ;
title(' ') ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p7A.png') ;


%  Plot Input Data
%
figure(3) ;
clf ;
axis([left right bottom top]) ;
mcolorc = mcolor ;
mcolorc((nc1 + 1):(n - 2),:) = ones((nc2 + nc3),1) * [0.5 0.5 0.5] ;
hold on ;
  for i = 1:n ;
    plot(mdata(1,i),mdata(2,i),markerstr(i),'Color',mcolorc(i,:), ...
                          'MarkerSize',6,'Linewidth',0.5) ;
  end ;
  plot((left + right) / 2,-0.25,'x','Color',[0.99 0.99 0.99]) ;
  text(left + 0.2 * (right - left), ...
       bottom + 0.98 * (top - bottom), ...
       ['CI = ' num2str(CI)]) ;
hold off ;
axis equal ;
axis off ;

%  Add fit Gaussian contour to plot
%
ncpts = 401 ;
vangles = linspace(0,2 * pi,ncpts) ;
    %  Equally spaced angles
mucirc = [cos(vangles); sin(vangles)] ;
    %  Equally spaced points on unit circle
muellips = vmean * ones(1,ncpts) + 2 * sqrtm(ecovmat) * mucirc ;
hold on ;
  plot(muellips(1,:),muellips(2,:),'k-') ;
  text(left + 0 * (right - left), ...
       bottom + 0.5 * (top - bottom), ...
       ['Gaussian CI = ' num2str(simCI)]) ;
hold off ;

%  Add simulated Gaussian data to plot
%
hold on ;
  plot(msim(1,:),msim(2,:),'k*','MarkerSize',4) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p7B.png') ;



