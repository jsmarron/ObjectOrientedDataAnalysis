disp('Running MATLAB script file OODAfig5p14.m') ;
%
%    Makes Figure 5.14 of the OODA book,
%    Two Scale Curves Data
%    curvdat analysis, of whitened data
%
%    Copied from OODAbookChpBFigP.m
%    in:        OODAbook\ChapterB
%


datafilestr = '..\..\DataSets\TwoScaleCurvesData' ;

d = 100 ;
n = 200 ;
xgrid = (1:d)' ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


mcadata = mdata ./ vec2matSM(std(mdata,0,2),n) ;
    %  matrix of correlation adjusted data


%  Generate graphics
%
paramstruct = struct('npc',1, ...
                     'iorient',3, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 1]) ;
outstruct = pcaSM(mcadata,paramstruct) ;
vpc = getfield(outstruct,'mpc') ;
    %  1 x n matrix of PC scores

[temp,vind] = sort(vpc) ;
mcadata = mcadata(:,vind) ;

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
curvdatSM(mcadata,paramstruct) ;
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
print('-dpng','OODAfig5p14A.png') ;


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
curvdatSM(mcadata,paramstruct) ;
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
print('-dpng','OODAfig5p14B.png') ;


%  Also make version with % sum of squares, for discussion in paper
%
figure(3) ;
clf ;
paramstruct = struct('itype',1, ...
                     'icolor',icolor, ...
                     'dolhtseed',37402983, ...
                     'iaxlim',1, ...
                     'iscreenwrite',1) ;
curvdatSM(mcadata,paramstruct) ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 14.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 13.5]) ; 
print('-dpng','OODAfig5p14C.png') ;



