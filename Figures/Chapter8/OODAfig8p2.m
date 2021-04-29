disp('Running MATLAB script file OODAfig8p2.m') ;
%
%    Makes Figure 8.2 of the OODA book,
%    Illustrates Manifold Basics
%
%    Copied from OODAbookChpGFigFLogExp.m
%    in:        OODAbook\ChapterG
%


%  Set basics
%
left = -0.4 ;
right = 1.4;
bottom = -0.4 ;
top = 1.4 ;
lw1 = 2.5 ;
lw2 = 6 ;

ngrid = 401 ;
mgrid1 = linspace(-pi/4, 3*pi/4, ngrid)' ;
mcircle1 = [cos(mgrid1),sin(mgrid1)] ;
theta = 1.2 ;
mgrid2 = linspace(0, theta, ngrid)' ;
mcircle2 = [cos(mgrid2),sin(mgrid2)] ;


%  make main plot
%
figure(1) ;
clf ;

plot(mcircle1(:,1),mcircle1(:,2),'k-','LineWidth',lw1) ;
hold on ;
  plot([left; right],[0; 0],'k-','LineWidth',lw1) ;
  plot([0; 0],[bottom; top],'k-','LineWidth',lw1) ;
  plot(mcircle2(:,1),mcircle2(:,2),'k--','LineWidth',lw2) ;
  plot([1,1],[0,theta],'k--','LineWidth',lw2) ;
  plot([1; 1],[bottom; top],'k:','LineWidth',lw1) ;
  plot([0; cos(theta)],[0; sin(theta)],'k:','LineWidth',lw1) ;
  text(0.08,0.07,'\theta','FontSize',24) ;
  text(0.35,1.03,'e^{i\theta}','FontSize',24) ;
  text(1.02,-0.07,'1 + 0i','FontSize',24) ;
  text(1.02,1.215,'1 + {\theta}i','FontSize',24) ;
hold off ;

axis square ;
axis([left right bottom top]) ;
axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[8.0, 8.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 7.5, 7.5]) ; 
print('-dpng','OODAfig8p2B.png') ;



