disp('Running MATLAB script file OODAfig15p9.m') ;
%
%    Makes Figure 15.9 of the OODA book,
%    Mass Flux data, SiZer Analysis
%
%    Copied from OODAbookChpNFigEMassFluxSiZer.m
%    in:        OODAbook\ChapterN
%

datafilestr = '..\..\DataSets\MassFluxData' ;

%  Read in data
%
mdata = xlsread(datafilestr) ;


d = size(mdata,1) ;
n = size(mdata,2) ;
xgrid = (1:d)' ;

figure(1) ;
clf ;

paramstruct = struct('npc',1, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 1]) ;
outstruct = pcaSM(mdata,paramstruct) ;
vscores = getfield(outstruct,'mpc') ;
    %  Row vector of PC1 scores

hmin = 10^0.4 ;
hmax = 10^1.4 ;
paramstruct = struct('iout',1, ...
                     'imovie',0, ...
                     'simflag',1, ...
                     'famoltitle','', ...
                     'sizertitle','', ...
                     'iscreenwrite',1, ...
                     'nfh',10, ...
                     'fhmin',hmin, ...
                     'fhmax',hmax, ...
                     'nsh',40, ...
                     'shmin',hmin, ...
                     'shmax',hmax, ...
                     'hhighlight',10^0.77) ;
sizerSM(vscores',paramstruct) ; 

%  Set dots to symbols
%
vfchil = get(gcf,'Children') ;
vachil = get(vfchil(2),'Children') ;
set(vachil(11),'Marker','o') ;
set(vachil(11),'MarkerSize',6) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[10.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 9.5, 11.5]) ; 
print('-dpng','OODAfig15p9.png') ;



