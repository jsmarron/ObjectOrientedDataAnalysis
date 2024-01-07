disp('Running MATLAB script file TiltedParabsExt.m') ;
%    Copied from OODAfig4p1.m,
%    Which made Figure 4.1 of the OODA book,
%    Toy example for PCA in FDA, 10-d Parabolas
%    with common axes to show diminishing variation
%

ipart = 3 ;    %  1 - Make Standard PCA using curvdatSM
               %  2 - Make PCA using curvdatSM, Low Added Noise 
               %  3 - Make PCA using curvdatSM, High Added Noise 
               

datafilestr = '..\..\DataSets\TiltedParabolasData' ;
datastr = 'Tilted Parabolas' ;


%  Read in data
%
mdata = xlsread(datafilestr) ;

d = size(mdata,1) ;
    %  dimension of each data curve
n = size(mdata,2) ;
    %  number of data curves


%  Set graphics and simulatin parameter
%
figure(1) ;
clf ;
basesavestr = 'TiltedParabsp' ;
rng(26387246) ;


if ipart == 1    %  Make Standard PCA using curvdatSM

  mdatain = mdata ;
  savestr = [basesavestr num2str(ipart) 'StandardPCA'] ;
  legendtext = '.' ;

elseif ipart == 2    %  Make PCA using curvdatSM, Low Added Noise 

  mdatain = mdata + 8 * randn(d,n) ;
  savestr = [basesavestr num2str(ipart) 'LowNoise'] ;
  legendtext = 'Low Added Noise' ;

elseif ipart == 3    %  Make PCA using curvdatSM, High Added Noise 

  mdatain = mdata + 40 * randn(d,n) ;
  savestr = [basesavestr num2str(ipart) 'HighNoise'] ;
  legendtext = 'High Added Noise' ;

end ;


paramstruct = struct('itype',1, ...
                     'viout',1, ...
                     'vipcplot',[0 1 2 3], ...
                     'icolor',1, ...
                     'dolhtseed',37402983, ...
                     'legendcellstr',{{datastr legendtext}}, ...
                     'iaxlim',1, ...
                     'savestr',savestr, ...
                     'savetype',2, ...
                     'iscreenwrite',1) ;
curvdatSM(mdatain,paramstruct) ;





%{
else ;    %  Make main graphic

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
  print('-dpng','OODAfig4p1A.png') ;


  %  Then lower part
  %
  figure(2) ;
  clf ;

  paramstruct = struct('itype',1, ...
                       'viout',1, ...
                       'vipcplot',[1 2 3], ...
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
  %  Turn off text in 8th panel
  vah = get(gcf,'Children') ;
  vah8c = get(vah(8),'Children') ;
  set(vah8c(1),'String','') ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig4p1B.png') ;


  %  Also make version with % sum of squares, for discussion in paper
  %
  figure(3) ;
  clf ;
  paramstruct = struct('itype',1, ...
                       'icolor',1, ...
                       'dolhtseed',37402983, ...
                       'legendcellstr',{{datastr}}, ...
                       'iaxlim',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig4p1C.png') ;
%}

