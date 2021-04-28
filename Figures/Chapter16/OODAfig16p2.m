disp('Running MATLAB script file OODAfig16p2.m') ;
%
%    Makes Figure 16.2 of the OODA book,
%    Parabolas and Outlier Data, PCA curvdat
%
%    Copied from OODAbookChpOFigC10dToynOut.m
%    in:        OODAbook\ChapterO
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\ParabolasAndOutlierData' ;
datastr = 'Parabolas' ;
n = 50 ;
d = 10 ;


if ipart == 0 ;    %  Create and save data

  %  Generate Toy Data
  %
  xgrid = (.5:1:d)' ;
  mdata = (xgrid - 6).^2 ;
    randn('seed',88769874) ;
    eps1 = 4 * randn(1,n) ;
    eps2 = .5 * randn(1,n) ;
    eps3 = 1 * randn(d,n) ;
  mdata = vec2matSM(mdata,n) + vec2matSM(eps1,d) + ...
                 vec2matSM(eps2,d) .* vec2matSM(xgrid-d/2,n) + eps3 ;
  mdata = [mdata, 15 * (sin(pi * xgrid) + 1)] ;
      %  This last line adds the outlier

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Generate graphics
  %
  mcolor = ones(n,1) * [0 0 0] ;
  mcolor = [mcolor; [1 0 0]] ;


  %  Top part first
  %
  figure(1) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[0], ...
                       'vicolplot',[1 2 3], ...
                       'icolor',mcolor, ...
                       'dolhtseed',37402983, ...
                       'legendcellstr',{{datastr}}, ...
                       'iaxlim',0, ...
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
  print('-dpng','OODAfig16p2A.png') ;


  %  Then lower part
  %
  figure(2) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[1 2 3], ...
                       'vicolplot',[1 3 4], ...
                       'icolor',mcolor, ...
                       'dolhtseed',37402983, ...
                       'legendcellstr',{{datastr}}, ...
                       'iaxlim',0, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;
  %  Turn off text in 2nd panel
  vah = get(gcf,'Children') ;
  vah2c = get(vah(2),'Children') ;
  set(vah2c(1),'String','') ;
  %  Turn off text in 5th panel
  vah = get(gcf,'Children') ;
  vah5c = get(vah(5),'Children') ;
  set(vah5c(1),'String','') ;
  %  Turn off text in 8th panel
  vah = get(gcf,'Children') ;
  vah8c = get(vah(8),'Children') ;
  set(vah8c(1),'String','') ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig16p2B.png') ;


end ;

