disp('Running MATLAB script file OODAfig9p9.m') ;
%
%    Makes Figures 9.9, 9.10 and 9.11 of the OODA book,
%    Shifted Betas - Vertical CurveDat
%
%    Copied from OODAbookChpHFigIJKToyFRPCA.m
%    in:        OODAbook\ChapterH
%


datafilestr = '..\..\DataSets\ShiftedBetasData' ;

d = 1001 ;
      %  dimension of each data curve
xgrid = linspace(0,1,d)' ;
n = 29 ;
      %  number of data curves
mxgrid = xgrid * ones(1,n) ;


%  Read in data
%
mfi = xlsread(datafilestr) ;


%  Run Fisher Rao Decomposition
%
[fn,qn,q0,fmean,mqn,gam] = time_warping(mfi,xgrid) ;


%  Make Figure 9.1:   Vertically Aligned PCA
%
figure(7) ;
clf ;
paramstruct = struct('vipcplot',[0], ...
                     'vicolplot',[1 2 3], ...
                     'icolor',2, ...
                     'iaxlim',1,  ...
                     'iscreenwrite',1) ;
curvdatSM(fn,paramstruct) ;
subplot(1,3,1) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
subplot(1,3,2) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')
subplot(1,3,3) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig9p9A.png') ;


figure(8) ;
clf ;
paramstruct = struct('vipcplot',[1], ...
                     'vicolplot',[1 3 4], ...
                     'icolor',2, ...
                     'iaxlim',1,  ...
                     'iscreenwrite',1) ;
curvdatSM(fn,paramstruct) ;
subplot(1,3,1) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
subplot(1,3,2) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig9p9B.png') ;


%  Make Figure J:   Warp function PCA
%
figure(9) ;
clf ;
paramstruct = struct('vipcplot',[0], ...
                     'vicolplot',[1 2 3], ...
                     'icolor',2, ...
                     'iaxlim',1,  ...
                     'iscreenwrite',1) ;
curvdatSM(gam,paramstruct) ;
subplot(1,3,1) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
subplot(1,3,2) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')
subplot(1,3,3) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig9p10A.png') ;


figure(10) ;
clf ;
paramstruct = struct('vipcplot',[1 2], ...
                     'vicolplot',[1 3 4], ...
                     'icolor',2, ...
                     'iaxlim',1,  ...
                     'iscreenwrite',1) ;
curvdatSM(gam,paramstruct) ;
subplot(2,3,1) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
subplot(2,3,2) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')
subplot(2,3,4) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
subplot(2,3,5) ;
  set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  vachil = get(gca,'Children') ;
  set(vachil(1),'String',' ')

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 7.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
print('-dpng','OODAfig9p10B.png') ;


%  Make Figure K:   Horizontal PCA
%
figure(11) ;
clf ;
colmap = RainbowColorsQY(n) ;

%  do PCA on Warping Functions    
%
paramstruct = struct('npc',4, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 1 0 0 1]) ;
outstruct = pcaSM(gam,paramstruct) ;
vmean = getfield(outstruct,'vmean') ;
a3proj = getfield(outstruct,'a3proj') ;

%  Make PCA style projection plots
%
fmean = mean(fn,2) ;
vax = axisSM(fmean) ;
for ipc = 1:3 ;
  subplot(1,3,ipc) ;
    plot(vmean + a3proj(:,1,ipc),fmean,'-','Color',colmap(1,:)) ;
      axis([0,1,vax]) ;
      hold on ;
        for idat = 2:n ;
          plot(vmean + a3proj(:,idat,ipc),fmean,'-','Color',colmap(idat,:)) ;
        end ;
      hold off ;
    set(gca,'XTick',[0.2; 0.4; 0.6; 0.8; 1])

end ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig9p11.png') ;



