disp('Running MATLAB script file OODAfig15p10.m') ;
%
%    Makes Figure 15.10 of the OODA book,
%    Kidney Cancer data, SiZer Analysis
%
%    Copied from OODAbookChpNFigGKidneyCanSiZer.m
%    in:        OODAbook\ChapterN
%

datafilestr = '..\..\DataSets\PanCanAllKidneyData' ;
    %  File copied from OODAbook\ChapterN, and renamed from PanCanKidneyDataAll.xlsx


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Get PC1 scores
%
paramstruct = struct('npc',1,...
                     'iscreenwrite',1,...
                     'viout',[0 0 0 0 1]) ;
outstruct = pcaSM(mdata,paramstruct) ;
mpc = getfield(outstruct,'mpc') ;
vpc1scores = mpc' ;
    %  turn row vector of scores into column for SiZer input


%  Do SiZer analysis
%
figure(1) ; 
clf ;
vax = axisSM(vpc1scores) ;
famoltitle = ' ' ;
paramstruct = struct('iout',2, ...
                     'imovie',0, ...
                     'xlabelstr','Kidney Cancer PC1 scores', ...
                     'famoltitle',famoltitle, ...
                     'sizertitle',' ', ...
                     'curvsizertitle',' ', ...
                     'minx',vax(1), ...
                     'maxx',vax(2), ...
                     'nfh',7, ...
                     'fhmin',3, ...
                     'fhmax',50, ...
                     'nsh',41, ...
                     'shmin',3, ...
                     'shmax',50, ...
                     'hhighlight',20) ;
sizerSM(vpc1scores,paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 11.5]) ; 
print('-dpng','OODAfig15p10.png') ;



