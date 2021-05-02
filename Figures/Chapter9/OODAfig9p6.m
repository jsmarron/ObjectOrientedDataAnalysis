disp('Running MATLAB script file OODAfig9p6.m') ;
%
%    Makes Figure 9.6 of the OODA book,
%    Illustration of warp orbits
%
%    Copied from 
%    in:        OODAbook\ChapterH
%

%  Generate Common Quantities
%
d = 1001 ;
xgrid = linspace(0,1,d)' ;
n = 21 ;
mxgrid = xgrid * ones(1,n) ;

%  Do piecewise power transformation
%
vp = 4.^linspace(-1,1,n) ;
mp = ones(d,1) * vp ;
txgrid = ((2 * mxgrid(1:ceil(d / 2),:)) .^ mp(1:ceil(d / 2),:)) / 2 ;
    %    First part (supported [0,0.5]
txgrid = [txgrid ;(1 - (((2 * (1 - mxgrid((ceil(d / 2) + 1):d,:))) ...
                                      .^ mp((ceil(d / 2) + 1):d,:)) / 2))] ;
    %    Second part (supported (0.5,1]

%  Construct rainbow color matrix, using lines from CurvDatSM.m
%
colmap = RainbowColorsQY(n) ;

%  Set up graphics
%
figure(1) ;
clf ;
Linewidth = 2 ;


subplot(1,2,1) ;
  vcurve = normpdf(xgrid,0.45,0.12) ;
  vcurve = vcurve + 0.3 * normpdf(xgrid,0.75,0.06) ;
  vcurve = vcurve + 0.02 * normpdf(xgrid,0.2,0.015) ;

  plot(txgrid(:,1),vcurve,'-','Color',colmap(1,:),'Linewidth',Linewidth) ;
  hold on ;
  for i = 2:n ;
    plot(txgrid(:,i),vcurve,'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
  end ;
  hold off ;


subplot(1,2,2) ;
  vwt = linspace(0.2,0.8,n) ;
  mcurve = normpdf(xgrid,0.38,0.1) * vwt ;
  mcurve = mcurve + 0.7 * (normpdf(xgrid,0.62,0.06) * (1 - vwt)) ;
  plot(xgrid,mcurve,'-','Linewidth',Linewidth) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.0]) ; 
print('-dpng','OODAfig9p6.png') ;


