disp('Running MATLAB script file OODAfig7p4.m') ;
%
%    Makes Figure 7.4 of the OODA book,
%    Illustrates Median Rotation Invariance
%
%    Copied from OODAbookChpEFigDToyMedianRotInv.m
%    in:        OODAbook\ChapterE
%


%  Set up data
%
no2 = 20 ;
vi = (1:no2)' / no2 ;
     %  equally spaced on [1/n,1]
vx1 = (1 - (1 - vi).^2) / sqrt(2) ;
     %  densely packed at outer edge
vy1 = vx1 - 1/2 ;
vx = [-vx1; 0; vx1] ;
vy = [vy1; -1/2; vy1] ;
chx = [-vx1(end); 0; vx1(end); -vx1(end)] ;
chy = [vy1(end); -1/2; vy1(end); vy1(end)] ;

theta1 = 0 ;
theta2 = pi/4 ;


%  Make graphics
%
figure(1) ;
clf ;
symlw = 2 ;
symms = 10 ;

subplot(1,2,1) ;    %  make first rotation plot
  vxrot = cos(theta1) * vx + sin(theta1) * vy ;
  vyrot = -sin(theta1) * vx + cos(theta1) * vy ;
  chxrot = cos(theta1) * chx + sin(theta1) * chy ;
  chyrot = -sin(theta1) * chx + cos(theta1) * chy ;
  plot(vxrot,vyrot,'ko','LineWidth',1,'MarkerSize',6) ;
    axis([-1,1,-1,1]) ;
    axis square ;
  xmed = median(vxrot) ;
  ymed = median(vyrot) ;
  vmedian = rmeanSM([vxrot vyrot]) ;
  hold on ;
    plot(xmed,ymed,'r+','LineWidth',symlw,'MarkerSize',symms) ;
    plot(vmedian(1),vmedian(2),'x','LineWidth',symlw, ...
                 'MarkerSize',symms,'Color',[0 0.6 0.6]) ;
  hold off ;


subplot(1,2,2) ;    %  make second rotation plot
  vxrot = cos(theta2) * vx + sin(theta2) * vy ;
  vyrot = -sin(theta2) * vx + cos(theta2) * vy ;
  chxrot = cos(theta2) * chx + sin(theta2) * chy ;
  chyrot = -sin(theta2) * chx + cos(theta2) * chy ;
  plot(vxrot,vyrot,'ko','LineWidth',1,'MarkerSize',6) ;
    axis([-1,1,-1,1]) ;
    axis square ;
  xmed = median(vxrot) ;
  ymed = median(vyrot) ;
  vmedian = rmeanSM([vxrot vyrot]) ;
  hold on ;
    plot(xmed,ymed,'r+','LineWidth',symlw,'MarkerSize',symms) ;
    plot(vmedian(1),vmedian(2),'x','LineWidth',symlw, ...
                 'MarkerSize',symms,'Color',[0 0.6 0.6]) ;
  hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig7p4.png') ;



