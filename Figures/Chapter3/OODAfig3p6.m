disp('Running MATLAB script file OODAfig3p6.m') ;
%
%    Makes Figure 3.6 of the OODA book,
%    Probability Distributions as data objects
%
%    Copied from OODAbookChpBFigU.m
%    in:        OODAbook\ChapterB
%

%  Set preliminaries
%
d = 401 ;
fs = 12 ;
xgrid = linspace(0,400,d)' ;
vden = nmfSM(xgrid,[120; 280],[1200; 1200],[1/3; 2/3]) ;
vcdf = cumsum(vden) ;

figure(1) ;
clf ;

subplot(1,3,1) ;
plot(xgrid,vden,'k-','LineWidth',3) ;
title('Density','FontSize',fs) ;
xlabel('x','FontSize',fs) ;
ylabel('density, f(x)','FontSize',fs) ;

subplot(1,3,2) ;
plot(xgrid,vcdf,'k-','LineWidth',3) ;
title('Cumulative','FontSize',fs) ;
xlabel('x','FontSize',fs) ;
ylabel('C. D. F., F(x)','FontSize',fs) ;

subplot(1,3,3) ;
plot(vcdf,xgrid,'k-','LineWidth',3) ;
title('Quantile','FontSize',fs) ;
xlabel('Probability, p','FontSize',fs) ;
ylabel('Quantile, Q(p)','FontSize',fs) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig3p6.png') ;


