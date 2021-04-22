disp('Running MATLAB script file OODAfig5p13.m') ;
%
%    Makes Figure 5.13 of the OODA book,
%    Two Scale Curves Data
%    curvdat analysis, original
%
%    Copied from OODAbookChpBFigO.m
%    in:        OODAbook\ChapterB
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\TwoScaleCurvesData' ;

d = 100 ;
n = 200 ;
xgrid = (1:d)' ;


if ipart == 0 ;    %  Generate and save data

  randn('state',75029743095) ;
  mcoeff = randn(4,n) ;
  mdata = [(ones(20,1) * 20 * mcoeff(1,:)); zeros(80,n)] ;
  mdata = mdata + [([ones(10,1); -ones(10,1)] * 10 * mcoeff(2,:)); zeros(80,n)] ;
  mdata = mdata + [zeros(20,n); (sin(pi * xgrid(21:100) / 20) * 0.5 * mcoeff(3,:))] ;
  mdata = mdata + [zeros(20,n); (cos(pi * xgrid(21:100) / 20) * 0.25 * mcoeff(4,:))] ;

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Generate graphics
  %
  paramstruct = struct('npc',1, ...
                       'iorient',3, ...
                       'iscreenwrite',1, ...
                       'viout',[0 0 0 0 1]) ;
  outstruct = pcaSM(mdata,paramstruct) ;
  vpc = getfield(outstruct,'mpc') ;
      %  1 x n matrix of PC scores

  [temp,vind] = sort(vpc) ;
  mdata = mdata(:,vind) ;

  icolor = RainbowColorsQY(n) ;


  %  Top part first
  %
  figure(1) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[0], ...
                       'vicolplot',[1 2 3], ...
                       'icolor',icolor, ...
                       'dolhtseed',37402983, ...
                       'iaxlim',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;
  subplot(1,3,2) ;
  title('Mean') ;
  %  Turn off text in 2nd panel
  vah = get(gcf,'Children') ;
  vah2c = get(vah(2),'Children') ;
  set(vah2c(1),'String','') ;
  subplot(1,3,3) ;
  title('Mean Residuals') ;
  %  Turn off text in 3rd panel
  vah = get(gcf,'Children') ;
  vah1c = get(vah(1),'Children') ;
  set(vah1c(1),'String','') ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 3.5]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
  print('-dpng','OODAfig5p13A.png') ;


  %  Then lower part
  %
  figure(2) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[1 2 3], ...
                       'vicolplot',[1 3 4], ...
                       'icolor',icolor, ...
                       'dolhtseed',37402983, ...
                       'iaxlim',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;
  %  Turn off text in 2nd panel
  vah = get(gcf,'Children') ;
  vah2c = get(vah(2),'Children') ;
  set(vah2c(1),'String','') ;
  %set(vah2c(5),'String','') ;
  %  Turn off text in 5th panel
  vah = get(gcf,'Children') ;
  vah5c = get(vah(5),'Children') ;
  set(vah5c(1),'String','') ;
  %set(vah5c(5),'String','') ;
  %  Turn off text in 8th panel
  vah = get(gcf,'Children') ;
  vah8c = get(vah(8),'Children') ;
  set(vah8c(1),'String','') ;
  %set(vah8c(5),'String','') ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig5p13B.png') ;


  %  Also make version with % sum of squares, for discussion in paper
  %
  figure(3) ;
  clf ;
  paramstruct = struct('itype',1, ...
                       'icolor',icolor, ...
                       'dolhtseed',37402983, ...
                       'iaxlim',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 14.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 13.5]) ; 
  print('-dpng','OODAfig5p13C.png') ;


end ;

