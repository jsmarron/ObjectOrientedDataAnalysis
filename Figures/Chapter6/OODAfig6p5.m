disp('Running MATLAB script file OODAfig6p5.m') ;
%
%    Makes Figure 6.5 of the OODA book,
%    Two Class Gaussian Data
%    curvdat analysis, original
%
%    Copied from OODAbookChpFFigCToyHeatMapVsPCA.m
%    in:        OODAbook\ChapterF
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\TwoClassGaussianData' ;

n1 = 100 ;
n2 = 100 ;
d = 20000 ;

mcolor = ones(n1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(n2,1) * [1 0 1])] ;
markerstr = 'x' ;
for i = 2:n1 ;
  markerstr = strvcat(markerstr,'x') ;
end ;
for i = 1:n2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;
cmap = [[ones(30,1) (linspace(0,1,30)' * [1 1])]; ...
        [(linspace(1,0,30)' * [1 1]) ones(30,1)]] ;


if ipart == 0 ;    %  Generate and save data

  %  Set preliminaries
  %
  rng(23784699) ;
      %  Seed for random number generators
  mu = 0.04 ;

  mdata = randn(d,n1 + n2) ;
  mdata(:,1:n1) = mdata(:,1:n1) + mu ;
  mdata(:,(n1 + 1):(n1 + n2)) = mdata(:,(n1 + 1):(n1 + n2)) - mu ;


  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Make Part 1: heatmap view
  %
  figure(1) ;
  clf ;
  mdatasc = 60 * ((mdata + 3) / 6) ;
      %  0-60 scaled version of data matrix
  colormap(cmap) ;
  vrowindex = ClusterOrderSM(mdatasc') ;
  vcolindex = ClusterOrderSM(mdatasc) ;
  image(mdatasc(vrowindex(1:200),vcolindex)) ;
  colorbar('EastOutside') ;
  orient portrait ;
  vfchil = get(gcf,'Children') ;
  set(vfchil(1),'YTickLabel',[-2 -1 0 1 2 3])


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig6p5.png') ;


end ;

