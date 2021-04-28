disp('Running MATLAB script file OODAfig17p2.m') ;
%
%    Makes Figure 17.2 of the OODA book,
%    Sine Wave Data, Column Object Centered, Heat Map - Column Curves - Row Curves
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

mdatacoc = mdatar - (mean(mdatar,2) * ones(1,n)) ;
   %  Column Object Centered Version


%  Make Part 2: Column Object Centered View
%
figure(2) ;
clf ;
mdatacocsc = 32 * (mdatacoc / dr9) + 33 ;
colormap(cmap) ;
subplot(1,3,1) ;
  image(mdatacocsc) ;
  title('Column Object Centered') ;
  colorbar('Location','EastOutside', ...
           'YTickLabel',{num2str(-dr9,2),num2str(-2 * dr9 / 3,2), ...
                         num2str(-dr9 / 3,2),num2str(dr9 / 3,2), ...
                         num2str(2 * dr9 / 3,2),num2str(dr9,2)}) ;
subplot(1,3,2) ;
  plot(vgrid,mdatacoc,'k') ;
  title('Column Data Objects') ;
  axis([0,21,-4,6]) ;
subplot(1,3,3) ;
  plot(hgrid',mdatacoc','k') ;
  title('Row Trait Objects') ;
  axis([0,11,-4,6]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p2.png') ;



