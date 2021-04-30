disp('Running MATLAB script file OODAfig9p2.m') ;
%
%    Makes Figure 9.2 of the OODA book,
%    Shifted Betas - PCA curvdat - poor compression
%
%    Copied from OODAbookChpHFigAToyBadPCA.m
%    in:        OODAbook\ChapterH
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\ShiftedBetasData' ;

d = 1001 ;
      %  dimension of each data curve
xgrid = linspace(0,1,d)' ;
n = 29 ;
      %  number of data curves
mxgrid = xgrid * ones(1,n) ;


if ipart == 0 ;    %  Generate and save data

  valpha = linspace(4.4,15.6,n) ;
  vbeta = 20 - valpha ;
  malpha = ones(d,1) * valpha ;
  mbeta = ones(d,1) * vbeta ;
  mfi = betapdf(mxgrid,malpha,mbeta) ;

  xlswrite([datafilestr '.xlsx'],mfi) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mfi = xlsread(datafilestr) ;


  %  Do curvdatSM analysis, top panel
  %
  figure(1) ;
  clf ;
  paramstruct = struct('vipcplot',[0], ...
                       'vicolplot',[1 2 3], ...
                       'icolor',2, ...
                       'iaxlim',1,  ...
                       'iscreenwrite',1) ;
  curvdatSM(mfi,paramstruct) ;
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
  print('-dpng','OODAfig9p2A.png') ;


  %  Do curvdatSM analysis, remaining panels
  %
  figure(2) ;
  clf ;
  paramstruct = struct('vipcplot',[1 2 3], ...
                       'vicolplot',[1 3 4], ...
                       'icolor',2, ...
                       'iaxlim',1,  ...
                       'iscreenwrite',1) ;
  curvdatSM(mfi,paramstruct) ;
  subplot(3,3,1) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  subplot(3,3,2) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
    vachil = get(gca,'Children') ;
    set(vachil(1),'String',' ')
  subplot(3,3,4) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  subplot(3,3,5) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
    vachil = get(gca,'Children') ;
    set(vachil(1),'String',' ')
  subplot(3,3,7) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
  subplot(3,3,8) ;
    set(gca,'XTickLabel',[0.2; 0.4; 0.6; 0.8; 1])
    vachil = get(gca,'Children') ;
    set(vachil(1),'String',' ')

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig9p2B.png') ;


end ;
