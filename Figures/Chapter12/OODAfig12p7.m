disp('Running MATLAB script file OODAfig12p7.m') ;
%
%    Makes Figure 12.7 of the OODA book,
%    High Dimensional Gaussian Data
%    Illustrates Dendrograms
%
%    Copied from OODAbookChpKFigFHierHiD.m
%    in:        OODAbook\ChapterK
%
 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\MassFluxData' ;

%  Set parameters
%
d = 500 ;
n = 30 ;
%  First is Euclidean Distance, Single Linkage
  linkparstr1 = 'single' ;
  linktitstr1 = 'Single' ;
  linkoutstr1 = 'Sing' ;
  distparstr1 = 'euclidean' ;
  disttitstr1 = 'Euclidean' ;
  distoutstr1 = 'Euc' ;
%  colthresh1 = 30.43 ;
  colthresh1 = 30.5 ;
%  Second is Euclidean Distance, Ward Linkage
  linkparstr2 = 'ward' ;
  linktitstr2 = 'Ward' ;
  linkoutstr2 = 'Ward' ;
  distparstr2 = 'euclidean' ;
  disttitstr2 = 'Euclidean' ;
  distoutstr2 = 'Euc' ;
  colthresh2 = 34.1 ;


if ipart == 0 ;    %  Generate and save data

  rng(59598530)  ;
  mdata = randn(d,n) ;
      %  Columns as data objects
  mdata = mdata - (mean(mdata,2) * ones(1,n)) ;
      %  Column object mean centering

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Graphic for dendrograms
  %
  figure(1) ;
  clf ;

  %  Make Dendrogram1 Single
  %
  subplot(1,2,1) ;
    Z1 = linkage(mdata',linkparstr1,distparstr1) ;
        %  Construct Hierarchical Cluster Tree 
        %  Treating rows as data objects
    [H1,T1,OUTPERM1] = dendrogram(Z1,0,'ColorThreshold',colthresh1) ;
        %  plot full dendrogram
    %title(['Gaussian, d=500, n=30, ' disttitstr1 ', ' linktitstr1]) ;
    set(gca,'XTickLabel',[]) ;

  %  Make Dendrogram2 Ward's
  %
  subplot(1,2,2) ;
    Z2 = linkage(mdata',linkparstr2,distparstr2) ;
        %  Construct Hierarchical Cluster Tree 
        %  Treating rows as data objects
    [H2,T2,OUTPERM2] = dendrogram(Z2,0,'ColorThreshold',colthresh2) ;
        %  plot full dendrogram
    %title(['Gaussian, d=500, n=30, ' disttitstr2 ', ' linktitstr2]) ;
    set(gca,'XTickLabel',[]) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 7.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
  print('-dpng','OODAfig12p7.png') ;


end ;

