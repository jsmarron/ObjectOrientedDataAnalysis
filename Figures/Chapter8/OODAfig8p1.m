disp('Running MATLAB script file OODAfig8p1.m') ;
%
%    Makes Figure 8.1 of the OODA book,
%    Illustrates Ciruclar Data Ideas
%
%    Copied from OODAbookChpGFigAToyDirectionalData.m
%    in:        OODAbook\ChapterG
%


figure(1) ;
clf ;

vtheta = linspace(0,2 * pi,400) ;
mcirc = [cos(vtheta); sin(vtheta)] ;

vthetadat = [14 8 350 342] * pi / 180 ;
mdata = [cos(vthetadat); sin(vthetadat)] ;
angmean = mean(vthetadat) ;
subplot(1,2,1) ;
  plot(mcirc(1,:),mcirc(2,:),'k-','LineWidth',3) ;
  hold on ;
    plot([0; 0],[-1.5; 1.5],'k-','LineWidth',2) ;
    plot([-1.5; 1.5],[0; 0],'k-','LineWidth',2) ;
    plot(mdata(1,:),mdata(2,:),'o','LineWidth',3,'MarkerSize',3,'Color',[0 .7 0]) ;
    plot(cos(angmean),sin(angmean),'rx','LineWidth',3,'MarkerSize',12) ;
    plot(cos(angmean + pi),sin(angmean + pi),'bx','LineWidth',3,'MarkerSize',12) ;
  hold off ;
  axis([-1.3 1.3 -1.3 1.3]) ;
  axis square ;

vthetadat = [89 89 89 89 85 85 85 271 271 271 271 275 275] * pi / 180 ;
vr = [1 1.08 1.16 1.24 1 1.08 1.16 1 1.08 1.16 1.24 1 1.08] ;
mdata = [vr .* cos(vthetadat); vr .* sin(vthetadat)] ;
angmean = mean([vthetadat(1:7) (vthetadat(8:13) - 2 * pi)])  ;
ptmean = mean([cos(vthetadat); sin(vthetadat)],2) ;
circmean = ptmean / norm(ptmean) ;
subplot(1,2,2) ;
  plot(mcirc(1,:),mcirc(2,:),'k-','LineWidth',3) ;
  hold on ;
    plot([0; 0],[-1.5; 1.5],'k-','LineWidth',2) ;
    plot([-1.5; 1.5],[0; 0],'k-','LineWidth',2) ;
    plot(mdata(1,:),mdata(2,:),'o','LineWidth',2,'MarkerSize',2,'Color',[0 .7 0]) ;
    plot(cos(angmean),sin(angmean),'bx','LineWidth',3,'MarkerSize',12) ;
    plot(ptmean(1),ptmean(2),'ro','LineWidth',3,'MarkerSize',8) ;
    plot(circmean(1),circmean(2),'rx','LineWidth',3,'MarkerSize',12) ;
    plot([0; circmean(1)],[0; circmean(2)],'r-','LineWidth',2) ;
  hold off ;
  axis([-1.3 1.3 -1.3 1.3]) ;
  axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[8.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 7.5, 3.5]) ; 
print('-dpng','OODAfig8p1.png') ;



