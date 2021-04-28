disp('Running MATLAB script file OODAfig17p1.m') ;
%
%    Makes Figure 17.1 of the OODA book,
%    Sine Wave Data, Raw, Heat Map - Column Curves - Row Curves
%
%    Copied from OODAbookChpPFigAToyCentering.m
%    in:        OODAbook\ChapterP
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\SineWaveData' ;
d = 20 ;
n = 10 ;
hgrid = [1:n] ;
vgrid = [1:d]' ;
cmap = [[ones(32,1) (linspace(0,1,32)' * [1 1])]; ...
        [(linspace(1,0,32)' * [1 1]) ones(32,1)]] ;


if ipart == 0 ;    %  Create and save data

  rng(23904575) ;
      %  Seed for random number generators
  sd = 0.001 ;
  hmeanvec = 0.3 * (hgrid - 5.8).^2 - 6 ;
  vmeanvec = sin(5 * pi * (vgrid - 1) / (d - 1)) + 3 ;
      %  this has been changed in this generation,
      %  to make sin wave have exactly 3 cycles, for belance in linear bit
  linfact = 0.005 ;
  vlinh = hgrid - mean(hgrid) ;
  vlinv = vgrid - mean(vgrid) ;
      %  this is a new part in this generation

  %  Generate Raw Data
  %
  mdatar = sd * rand(d,n) ;
  mdatar = mdatar + (ones(d,1) * hmeanvec) ;
  mdatar = mdatar + (vmeanvec * ones(1,n)) ;
  mdatar = mdatar + linfact * vlinv * vlinh ;

  xlswrite([datafilestr '.xlsx'],mdatar) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdatar = xlsread(datafilestr) ;

  vdatar = reshape(mdatar,d * n,1) ;
  vdatar = sort(abs(vdatar)) ;
  dr9 = vdatar(round(0.98 * d * n)) ;


  %  Make Part 1: Uncentered View
  %
  figure(1) ;
  clf ;
  mdatarsc = 32 * (mdatar / dr9) + 33 ;
      %  0-64 scaled version of data matrix, gives 98% outside range
  colormap(cmap) ;
  subplot(1,3,1) ;
    image(mdatarsc) ;
    title('Heatmap View, Uncentered') ;
    colorbar('Location','EastOutside', ...
             'YTickLabel',{num2str(-dr9,2),num2str(-2 * dr9 / 3,2), ...
                           num2str(-dr9 / 3,2),num2str(dr9 / 3,2), ...
                           num2str(2 * dr9 / 3,2),num2str(dr9,2)}) ;
  subplot(1,3,2) ;
    plot(vgrid,mdatar,'k') ;
    title('Column Data Objects') ;
    axis([0,21,-4,6]) ;
  subplot(1,3,3) ;
    plot(hgrid',mdatar','k') ;
    title('Row Trait Objects') ;
    axis([0,11,-4,6]) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 4.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
  print('-dpng','OODAfig17p1.png') ;


end ;

