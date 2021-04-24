disp('Running MATLAB script file OODAfig6p1.m') ;
%
%    Makes Figure 6.1 of the OODA book,
%    Two Clusters Data
%    Heatmap View
%
%    Copied from OODAbookChpFFigAToyHeatMapCluster.m
%    in:        OODAbook\ChapterF
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\TwoClustersData' ;

cmap = (linspace(0,20,21)' / 20) * ones(1,3) ;


if ipart == 0 ;    %  Generate and save data

  %  Set preliminaries
  %
  rng(34659896) ;
      %  Seed for random number generators
  mdata = 12 * rand(50,50) ;
  mdata(1:25,:) = mdata(1:25,:) + 4 ;
  mdata(:,1:25) = mdata(:,1:25) + 4 ;
  mdata = mdata(randperm(50),randperm(50)) ;

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Make main graphic
  %
  figure(1) ;
  clf ;

  subplot(1,3,1) ;    %  Random Ordering
    colormap(cmap) ;
    image(mdata) ;
    axis square ;

  subplot(1,3,2) ;    %  Clustered Columns
    vcolindex = ClusterOrderSM(mdata) ;
    colormap(cmap) ;
    image(mdata(:,vcolindex)) ;
    axis square ;

  subplot(1,3,3) ;    %  Clustered Rows and Columns
    vrowindex = ClusterOrderSM(mdata') ;
    colormap(cmap) ;
    image(mdata(vrowindex,vcolindex)) ;
    axis square ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 4.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
  print('-dpng','OODAfig6p1.png') ;


end ;

