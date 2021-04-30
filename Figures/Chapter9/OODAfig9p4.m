disp('Running MATLAB script file OODAfig9p4.m') ;
%
%    Makes Figure 9.4 of the OODA book,
%    Shifted Betas - Wasserstein MDS
%
%    Copied from OODAbookChpHFigNToyBadWasser.m
%    in:        OODAbook\ChapterH
%


datafilestr = '..\..\DataSets\ShiftedBetasData' ;

%  Note these are not exactly used, instead have more precise representation
%      from directly computing quantile functions (from same beta parameters)


%  Beta parameters from OODAfig9p1.m
%
n = 29 ;    %  number of data objects
np = 1001 ;
valpha = linspace(4.4,15.6,n) ;
vbeta = 20 - valpha ;
malpha = ones(np,1) * valpha ;
mbeta = ones(np,1) * vbeta ;

%  Generate Beta Quantile functions
%
pgrid = linspace(0,1,np)' ;
delp = pgrid(2) - pgrid(1) ;
mpgrid = pgrid * ones(1,n) ;
mq = betainv(mpgrid,malpha,mbeta) ;
    %  Beta quantiles

%  Create Wasserstein distance matrix
%
mdist = zeros(n,n) ;
for i = 1:n ;
  for j = (i + 1):n ;
    dist = sqrt(sum((mq(:,i) - mq(:,j)).^2) * delp) ;
    mdist(i,j) = dist ;
    mdist(j,i) = dist ;
  end ;
end ;


%  Do 2-d MDS
%
mscores2 = mdscale(mdist,2)' ;


%  Compute Components of Scree Plots, starting with 4-d MDS
%
mscores4 = mdscale(mdist,4)' ;
vev = sum(mscores4.^2,2) ;
vev = vev / sum(vev) ;
    %  heights of scree plot

%  Construct density curves and do PCA
%
d = 1001 ;
xgrid = linspace(0,1,d)' ;
delx = xgrid(2) - xgrid(1) ;
n = 29 ;
mxgrid = xgrid * ones(1,n) ;

valpha = linspace(4.4,15.6,n) ;
vbeta = 20 - valpha ;
malpha = ones(d,1) * valpha ;
mbeta = ones(d,1) * vbeta ;
mfi = betapdf(mxgrid,malpha,mbeta) ;

paramstruct = struct('npc',4, ...
                     'iscreenwrite',1, ...
                     'viout',[1]) ;
outstruct = pcaSM(mfi,paramstruct) ;
veigval = getfield(outstruct,'veigval') ;
vevd = veigval / sum(veigval) ;


%  Make graphics
%
figure(1) ;
clf ;
subplot(1,2,1) ;    %  MDS scores
  ax = 0.3 ;
  paramstruct = struct('icolor',2, ...
                       'vaxlim',[-ax ax -ax ax], ...
                       'titlestr','Wasserstein Metric MDS', ...
                       'xlabelstr','MDS 1', ...
                       'ylabelstr','MDS 2', ...
                       'iscreenwrite',1) ;
  projplot2SM(mscores2,eye(2),paramstruct) ;
  hold on ;
    plot([-ax; ax],[0; 0],'k-') ;
    plot([0; 0],[-ax; ax],'k-') ;
    axis square ;
  hold off ;


subplot(1,2,2) ;    %  log scree plots
  vax = axisSM(log10([vev vevd])) ;
  plot((1:4)',log10(vev),'m+-.','LineWidth',2) ;
  hold on ;
    plot((1:4)',log10(vevd),'go--','LineWidth',2) ;
    legend('Wasserstein MDS','Euclidean PCA','Location','NorthOutside') ;
    xlabel('Component Index') ;
    ylabel('log_{10} % Variation') ;
  hold off ;
  axis([0 5 vax(1) vax(2)]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 5.0]) ; 
print('-dpng','OODAfig9p4.png') ;


