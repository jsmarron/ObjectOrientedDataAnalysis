disp('Running MATLAB script file OODAfig5p17.m') ;
%
%    Makes graphic similar to Figure 5.17 for Chapter 5 of the OODA book,
%
%    Modified version of:  OODAbookChpDFigM.m
%    in:        OODAbook\ChapterD
%
%    Toy Example illustrating phase variation
%        and Fisher Rao analysis
%
%

%  Set basics
%
d = 1001 ;
xgrid = linspace(1 / (d + 1),1 - 1 / (d + 1),d)' ;
n = 31 ;
mxgrid = xgrid * ones(1,n) ;
rng(80465398) ;
    %  seed for random number generator

%  Generate Curves
%
valpha = 5 + 20 * rand(1,n) ;
vbeta = 60 - valpha ;
malpha = ones(d,1) * valpha ;
mbeta = ones(d,1) * vbeta ;
mfi1 = betapdf(mxgrid,malpha,mbeta) ;
vmax = max(mfi1,[],1) ;
mfi1 = mfi1 ./ (ones(d,1) * vmax) ;

valpha = 55 - 10 * rand(1,n) ;
vbeta = 60 - valpha ;
malpha = ones(d,1) * valpha ;
mbeta = ones(d,1) * vbeta ;
mfi2 = betapdf(mxgrid,malpha,mbeta) ;
vmax = max(mfi2,[],1) ;
mfi2 = mfi2 ./ (ones(d,1) * vmax) ;

ht =  linspace(0.3,-0.3,n) ;
mht = ones(d,1) * ht ;
mfi = (1 + mht) .* mfi1 + (1 - mht) .* mfi2 ;


%  Set up graphics
%
figure(10) ;
clf ;
colmap = RainbowColorsQY(n) ;
savestrpre = 'ToyEgEJS' ;
Linewidth = 1 ;
LinewidthMean = 3 ;


%  Plot Raw Data curves
%
subplot(1,2,1) ;
plot(xgrid,mfi(:,1),'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(xgrid,mfi(:,i),'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;
plot(xgrid,mean(mfi,2),'k--','Linewidth',LinewidthMean) ;
hold off ;


%  Run Fisher Rao Decomposition
%
%addpath('C:\Users\marron\Documents\Research\MatlabSoftware\FRwarping-PNS\DerekTuckerSoftware','-end') ;
[fn,qn,q0,fmean,mqn,gam] = time_warping(mfi,xgrid) ;


%  Show Amplitude Variation
%
figure(10) ;
subplot(1,2,2) ;
plot(xgrid,fn(:,1),'-','Color',colmap(1,:),'LineWidth',Linewidth) ;
hold on ;
for i = 2:n ;
  plot(xgrid,fn(:,i),'-','Color',colmap(i,:),'Linewidth',Linewidth) ;
end ;
plot(xgrid,mean(fn,2),'k--','Linewidth',LinewidthMean) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig5p17.png') ;



