disp('Running MATLAB script file OODAfig7p6.m') ;
%
%    Makes Figure 7.6 of the OODA book,
%    Illustrates metrics on sphere
%
%    Copied from OODAbookChpEFigHSphereHorseshoe.m
%    in:        OODAbook\ChapterE
%


%  Set basics
%
n = 100 ;
sig1 = pi / 3 ;
sig2 = pi / 50 ;   
rng(50395609) ;
    %  set seed for random number generator
maxiter = 1000 ;
options = statset('MaxIter',maxiter)  ;

figure(1) ;
clf ;

%  Generate points
%
mtheta = - 2 * pi / 3 ;
vtheta = sig1 * randn(1,n) + mtheta ;
vphi = sig2 * randn(1,n) ;
vx = cos(vtheta) .* cos(vphi) ;
vy = sin(vtheta) .* cos(vphi) ;
vz = sin(vphi) ;

%  Compute Euclidean Distance Matrix and MDS scores
%
mdiste = sqrt((ones(n,1) * vx - vx' * ones(1,n)).^2 + ...
              (ones(n,1) * vy - vy' * ones(1,n)).^2 + ...
              (ones(n,1) * vz - vz' * ones(1,n)).^2) ;
mdsce = mdscale(mdiste,2,'Options',options)' ;

%  Compute Geodesic Distance Matrix and MDS scores
%
mip = (vx' * vx) + (vy' * vy) + (vz' * vz) ;
mip = min(mip,1) ;
    %  avoids problem with values giving complex acos
mdistg1 = acos(mip) ;
for i = 1:n ;
  mdistg1(i,i) = 0 ;
      %  avoids problem of slight non-zeroes on diagonal
end ;
%  Problem with above is the acos only gave angles in [0,pi],
%  which resulted in a horseshoe 
%  but to correctly handle non-linearity, 
%  need to work on full range [0,2pi]   
%  (with respect to an appropriate split point)

%  Here comes second attempt
%
mdistg2 = zeros(n,n) ;
for i = 1:(n - 1) ;
  for j = (i + 1):n ;
    ip = vx(i) * vx(j) + vy(i) * vy(j) + vz(i) * vx(j) ;
    ip = min(ip,1) ;
    ip = max(ip,-1) ;
    dist = acos(ip) ;
    if abs(vtheta(i) - vtheta(j)) > pi ;  %  spread thetas used as indication
                                          %  of need for adjustment (not exact
                                          %  but seems a reasonable approximation
      dist = 2 * pi - dist ;
    end ;
    mdistg2(i,j) = dist ;
    mdistg2(j,i) = dist ;
  end ;
end ;

mdscg = mdscale(mdistg2,2,'Options',options)' ;


subplot(1,3,1) ;    %  Plot points on S2

  ngrid = 50 ;
      %  number of grid points for semicircles, etc.
  nlong = 12 ;
      %  number of lines of longitude to show
  vlongangle1 = linspace(0,2 * pi * (nlong - 1) / nlong,nlong) ;
  vlongangle2 = linspace(-pi,pi,ngrid) ;
  mlongangle1 = vec2matSM(vlongangle1,ngrid) ;
  mlongangle2 = vec2matSM(vlongangle2',nlong) ;
  mxlong = cos(mlongangle1) .* cos(mlongangle2) ;
  mylong = sin(mlongangle1) .* cos(mlongangle2) ;
  mzlong = sin(mlongangle2) ;
  plot3(mxlong,mylong,mzlong,'-','Color',[0.7 0.7 0.7]) ;
      %  lines of longitude
  %title('Data on S^2') ;
  axis([-1.1 1.1 -1.1 1.1 -1.1 1.1]) ;
  axis equal ;

  ngrid = 100 ;
      %  number of grid points for circles, etc.
  nlat = 11 ;
      %  number of lines of latitude to show
  vlatangle1 = linspace(0,2 * pi ,ngrid) ;
  vlatangle2 = linspace(-pi * (nlat - 1) / nlat,pi * (nlat - 1) / nlat,nlat) ;
  mlatangle1 = vec2matSM(vlatangle1',nlat) ;
  mlatangle2 = vec2matSM(vlatangle2,ngrid) ;
  mxlat = cos(mlatangle1) .* cos(mlatangle2) ;
  mylat = sin(mlatangle1) .* cos(mlatangle2) ;
  mzlat = sin(mlatangle2) ;
  hold on ;
    plot3(mxlat,mylat,mzlat,'-','Color',[0.7 0.7 0.7]) ;
        %  Lines of latitude
    plot3(vx,vy,vz,'bo','LineWidth',2) ;
        %  data points
  hold off ;

ax1 = 1.7 ;
subplot(1,3,2) ;    %  Plot Euclidean MDS
  paramstruct = struct('icolor','b', ...
                       'markerstr','o', ...
                       'iscreenwrite',1) ;
  projplot2SM(mdsce,eye(2),paramstruct) ;
  axis([-ax1 ax1 -ax1 ax1]) ;
  axis square ;

ax2 = 3.3 ;
subplot(1,3,3) ;    %  Plot Geodesic MDS
  paramstruct = struct('icolor','b', ...
                       'markerstr','o', ...
                       'iscreenwrite',1) ;
  projplot2SM(mdscg,eye(2),paramstruct) ;
  axis([-ax2 ax2 -ax2 ax2]) ;
  axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig7p6.png') ;



