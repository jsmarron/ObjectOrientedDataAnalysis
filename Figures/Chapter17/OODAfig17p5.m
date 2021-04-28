disp('Running MATLAB script file OODAfig17p5.m') ;
%
%    Makes Figure 17.5 of the OODA book,
%    Sine Wave Data, Column Object PCA
%
%    Copied from OODAbookChpPFigAToyCentering.m
%    in:        OODAbook\ChapterP
%

datafilestr = '..\..\DataSets\SineWaveData' ;
d = 20 ;
n = 10 ;
hgrid = [1:n] ;
vgrid = [1:d]' ;
cmap = [[ones(32,1) (linspace(0,1,32)' * [1 1])]; ...
        [(linspace(1,0,32)' * [1 1]) ones(32,1)]] ;


%  Read in data
%
mdatar = xlsread(datafilestr) ;

vdatar = reshape(mdatar,d * n,1) ;
vdatar = sort(abs(vdatar)) ;
dr9 = vdatar(round(0.98 * d * n)) ;


%  Make Part 5;  Column object curvdatSM
%
figure(5) ;
clf ;
paramstruct = struct('vipcplot',[0], ...
                     'vicolplot',[1 2 3], ...
                     'nevcompute',6, ...
                     'icolor',2, ...
                     'iaxlim',1, ...
                     'iscreenwrite',1) ;
curvdatSM(mdatar,paramstruct) ;
subplot(1,3,2) ;
  vachil = get(gca,'Children') ;
  set(vachil(1),'String','') ;
subplot(1,3,3) ;
  vachil = get(gca,'Children') ;
  set(vachil(1),'String','') ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p5A.png') ;


figure(6) ;
clf ;
paramstruct = struct('vipcplot',[1], ...
                     'vicolplot',[1 3 4], ...
                     'nevcompute',6, ...
                     'icolor',2, ...
                     'iaxlim',1, ...
                     'iscreenwrite',1) ;
curvdatSM(mdatar,paramstruct) ;
subplot(1,3,2) ;
  vachil = get(gca,'Children') ;
  set(vachil(1),'String','') ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p5B.png') ;



