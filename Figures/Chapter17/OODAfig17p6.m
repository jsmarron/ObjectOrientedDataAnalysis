disp('Running MATLAB script file OODAfig17p6.m') ;
%
%    Makes Figure 17.6 of the OODA book,
%    Sine Wave Data, Row Object PCA
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


%  Make Part 6: Row object curvdatSM
%
figure(7) ;
clf ;
icolor = HeatColorsSM(d) ;
paramstruct = struct('vipcplot',[0], ...
                     'vicolplot',[1 2 3], ...
                     'nevcompute',6, ...
                     'icolor',icolor, ...
                     'iaxlim',1, ...
                     'iscreenwrite',1) ;
curvdatSM(mdatar',paramstruct) ;
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
print('-dpng','OODAfig17p6A.png') ;


figure(8) ;
clf ;
icolor = HeatColorsSM(d) ;
paramstruct = struct('vipcplot',[1], ...
                     'vicolplot',[1 3 4], ...
                     'nevcompute',6, ...
                     'icolor',icolor, ...
                     'iaxlim',1, ...
                     'iscreenwrite',1) ;
curvdatSM(mdatar',paramstruct) ;
subplot(1,3,2) ;
  vachil = get(gca,'Children') ;
  set(vachil(1),'String','') ;
subplot(1,3,3) ;
  vachil = get(gca,'Children') ;
  nc = length(vachil) ;
  for ic = 1:(nc - 1) ;
    ht = get(vachil(ic),'YData') ;
    set(vachil(ic),'YData',(0.043 + 4 *(ht - 0.0832)))
  end ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p6B.png') ;



