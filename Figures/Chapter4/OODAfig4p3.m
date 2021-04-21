disp('Running MATLAB script file OODAfig4p3.m') ;
%
%    Makes Figure 4.3 of the OODA book,
%    Toy example for PCA in FDA, 50-d Double Arches
%
%    Copied from OODAbookChpBFigI.m
%    in:        OODAbook\ChapterB
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\TwinArchesData' ;
datastr = '2 Clusters, #2' ;


if ipart == 0 ;    %  Generate and save data

  d = 50 ;
  n = 50 ;
  xgrid = (.5:1:d)' ;
    randn('seed',93759872) ;
    rand('seed',30458744) ;
  mdata = 5 * (1 - cos(4 * pi * xgrid / d)) ;
  mdata = vec2matSM(mdata,n) ;
    halfd = floor(d/2) ;
    mflag = (1 - 2 * (rand(2,d) > .5)) ;
         %  random +- 1's
  mdata(1:halfd,:) = vec2matSM(mflag(1,:),halfd) .* mdata(1:halfd,:) ;
  mdata((halfd+1):d,:) = vec2matSM(mflag(2,:),d-halfd) .* ...
                                                mdata((halfd+1):d,:) ;
    eps3 = 1 * randn(d,n) ;
  mdata = mdata + eps3 ;


  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;

  d = size(mdata,1) ;
      %  dimension of each data curve
  n = size(mdata,2) ;
      %  number of data curves


  %  Top part first
  %
  figure(1) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[0], ...
                       'vicolplot',[1 2 3], ...
                       'icolor',1, ...
                       'dolhtseed',37402983, ...
                       'legendcellstr',{{datastr}}, ...
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
  print('-dpng','OODAfig4p3A.png') ;


  %  Then lower part
  %
  figure(2) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[1 2], ...
                       'vicolplot',[1 3 4], ...
                       'icolor',1, ...
                       'dolhtseed',37402983, ...
                       'legendcellstr',{{datastr}}, ...
                       'iaxlim',1, ...
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


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 8.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 7.5]) ; 
  print('-dpng','OODAfig4p3B.png') ;


end ;
