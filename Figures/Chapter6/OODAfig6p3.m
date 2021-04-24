disp('Running MATLAB script file OODAfig6p3.m') ;
%
%    Makes Figure 6.3 of the OODA book,
%    Illustrates Heatmap Scaling
%
%    Copied from OODAbookChpFFigBToyHeatMapScaling.m
%    in:        OODAbook\ChapterF
%

rng(90745394) ;
    %  Seed for random number generators
d = 50 ;
sd1 = 2 ;
sd2 = 3 ;
sd3 = 1 ;
mdata = zeros(d,d) ;
xgrid = linspace(0.5,d - 0.5,d) ;
ygrid = linspace(0.5,d - 0.5,d)' ;
mdata = mdata + 10000 * normpdf(ygrid,1 / 3 * d,sd1) * normpdf(xgrid,2 / 3 * d,sd1) ;
    %  Generate big peak  
mdata = mdata + (1000 * normpdf(ygrid,1 / 3 * d,sd2) * normpdf(xgrid,1 / 3 * d,sd2)) ;
mdata = mdata + (1000 * normpdf(ygrid,2 / 3 * d,sd2) * normpdf(xgrid,1 / 3 * d,sd2)) ;
mdata = mdata + (1000 * normpdf(ygrid,2 / 3 * d,sd2) * normpdf(xgrid,2 / 3 * d,sd2)) ;
    %  Generate small peaks  
mdata = mdata + (2 + sin(ygrid) * sin(xgrid)) ; 
    %  Generate texture

cmap = (linspace(0,20,21)' / 20) * ones(1,3) ;
mdata = 20 * mdata / max(max(mdata)) ;


%  Make Part 2: heatmap, log scale
%
figure(2) ;
clf ;
colormap(cmap) ;
mdatals = log10(mdata) ;
mdatals = mdatals - min(min(mdatals)) ;
mdatals = 20 * mdatals / max(max(mdatals)) ;
subplot(1,2,1) ;
  image(mdatals) ;
subplot(1,2,2) ;
  vdatals = reshape(mdatals,1,d^2) ;
  paramstruct = struct('icolor','k', ...
                       'markerstr','o', ...
                       'datovlaymax',0.8, ...
                       'datovlaymin',0.2, ...
                       'iscreenwrite',1) ;
  projplot1SM(vdatals,1,paramstruct) ;
  vax = axis ;
  hold on ;
    for i = 1:19 ;
      plot([i;i],[vax(3);vax(4)],'k:') ;
    end ;
  hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig6p3.png') ;



