disp('Running MATLAB script file OODAfig4p2.m') ;
%
%    Makes Figure 4.2 of the OODA book,
%    Toy example for PCA in FDA, 10-d Parabolas
%    with axes that fill the graphical space (more typical)
%
%    Copied from OODAbookChpBFigH.m
%    in:        OODAbook\ChapterB
%

datafilestr = '..\..\DataSets\TiltedParabolasData' ;
datastr = 'Parabolas' ;


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
                     'iscreenwrite',1) ;
curvdatSM(mdata,paramstruct) ;
%  Turn off text in 2nd panel
vah = get(gcf,'Children') ;
vah2c = get(vah(2),'Children') ;
set(vah2c(1),'String','') ;
%  Turn off text in 3rd panel
vah = get(gcf,'Children') ;
vah1c = get(vah(1),'Children') ;
set(vah1c(1),'String','') ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig4p2A.png') ;


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
print('-dpng','OODAfig4p2B.png') ;

