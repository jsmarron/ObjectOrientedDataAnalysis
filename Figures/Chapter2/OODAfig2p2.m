disp('Running MATLAB script file OODAfig2p2.m') ;
%
%    Makes Figure 1.9 of the OODA book,
%    Which Constructed Simple Examples, 
%    Illustrating Decomposition into Phase and Amplitude Variation
%
%    Copied from OODAbookChp1FigL.m
%    in:        OODAbook\Chapter1
%


%  Generate Common Quantities
%
d = 1001 ;
xgrid = linspace(1 / (d + 1),1 - 1 / (d + 1),d)' ;
n = 31 ;
mxgrid = xgrid * ones(1,n) ;

%  Generate Data Curves
%
rng(98459893 ) ;
    %  seed for random number generator

valpha = linspace(5,25,n) ;
vbeta = 60 - valpha ;
malpha = ones(d,1) * valpha ;
mbeta = ones(d,1) * vbeta ;
mfi1 = betapdf(mxgrid,malpha,mbeta) ;
vmax = max(mfi1,[],1) ;
mfi1 = mfi1 ./ (ones(d,1) * vmax) ;

valpha = linspace(55,45,n) ;
vbeta = 60 - valpha ;
malpha = ones(d,1) * valpha ;
mbeta = ones(d,1) * vbeta ;
mfi2 = betapdf(mxgrid,malpha,mbeta) ;
vmax = max(mfi2,[],1) ;
mfi2 = mfi2 ./ (ones(d,1) * vmax) ;

rht =  0.6 * (rand(1,n) - 0.5) ;
mrht = ones(d,1) * rht ;
mfi = (1 + mrht) .* mfi1 + 0.7 * (1 - mrht) .* mfi2 ;
vmeanmfi = mean(mfi,2) ;

colmap = RainbowColorsQY(n) ;

%  Set up graphics
%
savestrpre = 'OODAbookChp1FigL' ;
Linewidth = 1 ;
Linewidthm = 2 ;
    %  for ploting sample mean


%  Plot Raw Data curves
%
figure(10) ;
clf ;
plot(xgrid,mfi(:,1),'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(xgrid,mfi(:,i),'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;

vax = axisSM(mfi) ;
axis([0 1 0 vax(2)]) ;
set(gca,'XTickLabelMode','Manual')
set(gca,'XTickLabel',[])
set(gca,'XTick',[])
set(gca,'YTickLabelMode','Manual')
set(gca,'YTickLabel',[])
set(gca,'YTick',[])

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig2p2A.png') ;


%  Run Fisher Rao Decomposition
%
[fn,qn,q0,fmean,mqn,gam] = time_warping(mfi,xgrid) ;
vmeanfn = mean(fn,2) ;


%  Show Amplitude Variation
%
figure(2) ;
clf ;
plot(xgrid,fn(:,1),'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(xgrid,fn(:,i),'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;

vax = axisSM(fn) ;
axis([0 1 0 vax(2)]) ;
set(gca,'XTickLabelMode','Manual')
set(gca,'XTickLabel',[])
set(gca,'XTick',[])
set(gca,'YTickLabelMode','Manual')
set(gca,'YTickLabel',[])
set(gca,'YTick',[])

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig2p2B.png') ;


%  Show Estimated Warps
%
figure(3) ;
clf ;
plot(xgrid,gam(:,1),'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(xgrid,gam(:,i),'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;

axis([0 1 0 1]) ;
set(gca,'XTickLabelMode','Manual')
set(gca,'XTickLabel',[])
set(gca,'XTick',[])
set(gca,'YTickLabelMode','Manual')
set(gca,'YTickLabel',[])
set(gca,'YTick',[])

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig2p2C.png') ;


%  Show Phase Variation
%
figure(4) ;
clf ;
plot(gam(:,1),fmean,'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(gam(:,i),fmean,'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;

vax = axisSM(fmean) ;
axis([0 1 0 vax(2)]) ;
set(gca,'XTickLabelMode','Manual')
set(gca,'XTickLabel',[])
set(gca,'XTick',[])
set(gca,'YTickLabelMode','Manual')
set(gca,'YTickLabel',[])
set(gca,'YTick',[])

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig2p2D.png') ;


