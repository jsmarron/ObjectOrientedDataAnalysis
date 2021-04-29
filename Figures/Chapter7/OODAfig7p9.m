disp('Running MATLAB script file OODAfig7p9.m') ;
%
%    Makes Figure 7.9 of the OODA book,
%    Illustrates Wasserstein metric on densities
%
%    Copied from OODAbookChpEFigGWasserstein.m
%    in:        OODAbook\ChapterE
%


%  Set Mixture Parameters
%
vmu1 = [0.33; 0.75; 0.66] ; 
vsig1 = [0.15; 0.18; 0.025] ; 
vsig21 = vsig1.^2 ; 
vw1 = [0.64; 0.31; 0.05] ;

vmu2 = [0.33; 0.75] ; 
vsig2 = [0.175; 0.19] ; 
vsig22 = vsig2.^2 ; 
vw2 = [0.67; 0.33] ;

vmu3 = [0.33; 0.75; 0.75] ; 
vsig3 = [0.135; 0.185; 0.025] ; 
vsig23 = vsig3.^2 ; 
vw3 = [0.64; 0.31; 0.05] ;


%  Compute Densities
%
ng = 1001 ;
lw = 2 ;
xgrid = linspace(-1,2,ng)' ;
delx = xgrid(2) - xgrid(1) ;
vf1 = nmfSM(xgrid,vmu1,vsig21,vw1) ;
vf2 = nmfSM(xgrid,vmu2,vsig22,vw2) ;
vf3 = nmfSM(xgrid,vmu3,vsig23,vw3) ;
axf = axisSM([vf1 vf2 vf3]) ;

L2Est1 = sqrt(sum((vf1 - vf2).^2 * delx)) 
L2Est2 = sqrt(sum((vf1 - vf3).^2 * delx)) 

%  Compute CDFs
%
mcdf1 = normcdf(xgrid * ones(1,3), ones(ng,1) * vmu1', ...
                ones(ng,1) * vsig1') ;
vcdf1 = mcdf1 * vw1 ;
mcdf2 = normcdf(xgrid * ones(1,2), ones(ng,1) * vmu2', ...
                ones(ng,1) * vsig2') ;
vcdf2 = mcdf2 * vw2 ;
mcdf3 = normcdf(xgrid * ones(1,3), ones(ng,1) * vmu3', ...
                ones(ng,1) * vsig3') ;
vcdf3 = mcdf3 * vw3 ;

%  Compute Quantile Functions
%
pgrid = linspace(0.005,0.9995,1000) ;
delp = pgrid(2) - pgrid(1) ;
vqf1 = interp1(vcdf1,xgrid,pgrid) ;
vqf2 = interp1(vcdf2,xgrid,pgrid) ;
vqf3 = interp1(vcdf3,xgrid,pgrid) ;
vax = axisSM([vqf1 vqf2 vqf3]) ;

W2Est1 = sqrt(sum((vqf1 - vqf2).^2 * delp)) 
W2Est2 = sqrt(sum((vqf1 - vqf3).^2 * delp)) 


%  Plot Densities
%
figure(1) ;
clf ;
plot(xgrid,vf1,'k-','LineWidth',lw) ;
hold on;
  plot(xgrid,vf2,'k--','LineWidth',lw) ;
  plot(xgrid,vf3,'k:','LineWidth',lw) ;
  plot([0 0],[0,axf(2)],'k-') ;
  plot([1 1],[0,axf(2)],'k-') ;
%  title('Stone Kooperberg example, density on [0,1]') ;
  text(0.6,0.95 * axf(2),['L^2 for Est 1 = ' num2str(L2Est1)]) ;
  text(0.6,0.90 * axf(2),['L^2 for Est 2 = ' num2str(L2Est2)]) ;
  text(0.6,0.85 * axf(2),['W^2 for Est 1 = ' num2str(W2Est1)]) ;
  text(0.6,0.80 * axf(2),['W^2 for Est 2 = ' num2str(W2Est2)]) ;
hold off ;
axis([0 1 0 axf(2)]) ;
legend('True Curve','Estimate 1','Estimate 2','Location','South')


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[8.0, 6.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 7.5, 5.5]) ; 
print('-dpng','OODAfig7p9.png') ;



