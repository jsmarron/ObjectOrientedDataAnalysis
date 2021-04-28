disp('Running MATLAB script file OODAfig17p4.m') ;
%
%    Makes Figure 17.4 of the OODA book,
%    Sine Wave Data, Overall Centered, Heat Map - Column Curves - Row Curves
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

mdataoac = mdatar - (mean(mdatar,2) * ones(1,n)) ...
                  - (ones(d,1) * mean(mdatar,1)) + mean(mean(mdatar)) ;
   %  Overall Centered Version


%  Make Part 4: Overall Centered View
%
figure(4) ;
clf ;
mdataoacsc = 32 * (20 * mdataoac / dr9) + 33 ;
colormap(cmap) ;
subplot(1,3,1) ;
  image(mdataoacsc) ;
  title('Double Centered') ;
  colorbar('Location','EastOutside', ...
           'YTickLabel',{num2str(-dr9 / 20,2),num2str(-2 * dr9 / 60,2), ...
                         num2str(-dr9 / 60,2),num2str(dr9 / 60,2), ...
                         num2str(2 * dr9 / 60,2),num2str(dr9 / 20,2)}) ;
subplot(1,3,2) ;
  plot(vgrid,mdataoac,'k') ;
  title('Column Data Objects') ;
  axis([0,21,-4,6]) ;
subplot(1,3,3) ;
  plot(hgrid',mdataoac','k') ;
  title('Row Trait Objects') ;
  axis([0,11,-4,6]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p4.png') ;



