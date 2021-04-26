disp('Running MATLAB script file OODAfig13p5.m') ;
%
%    Makes Figure 13.5 of the OODA book,
%    Four Cluster data, SigClust on two blue clusters
%
%    Copied from OODAbookChpLFigESigClustTwoClust.m
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
bottom = -1; 
top = 1 ;


figure(1) ;
clf ;
mdatabc = mdata(:,(nc1 + 1):(n - 2)) ;
nbc = size(mdatabc,2) ;
vflagb = logical([ones(1,nc2) zeros(1,nc3)]) ;
CI = ClustIndSM(mdatabc,vflagb,~vflagb) ;
paramstruct = struct('npc',2, ...
                     'iscreenwrite',1, ...
                     'viout',[1 1 1]) ;
outstruct = pcaSM(mdatabc,paramstruct) ;
veigval = getfield(outstruct,'veigval') ;
meigvec = getfield(outstruct,'meigvec') ;
vmean = getfield(outstruct,'vmean') ;
ecovmat = meigvec * diag(veigval) * meigvec' ;
msim = vmean * ones(1,nbc) + sqrtm(ecovmat) * randn(2,nbc) ;
[BestClass, simCI] = SigClust2meanFastSM(msim) ;

vclass = [ones(1,nc2) (2 * ones(1,nc3))] ;
paramstruct = struct('vclass',vclass, ...
                     'iCovEst',2, ...
                       'datastr',' ', ...
                     'iscreenwrite',1) ;
SigClustSM(mdatabc,paramstruct) ;
title(' ') ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p5A.png') ;


%  Plot Input Data
%
figure(3) ;
clf ;
axis([left right bottom top]) ;
mcolorc = mcolor ;
mcolorc(1:nc1,:) = ones(nc1,1) * [0.5 0.5 0.5] ;
mcolorc(n - 1,:) = [0.5 0.5 0.5] ;
mcolorc(n,:) = [0.5 0.5 0.5] ;
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
hold off ;

%  Add simulated Gaussian data to plot
%
hold on ;
  plot(msim(1,:),msim(2,:),'k*','MarkerSize',4) ;
  text(left + 0 * (right - left), ...
       bottom + 0.5 * (top - bottom), ...
       ['Gaussian CI = ' num2str(simCI)]) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p5B.png') ;



