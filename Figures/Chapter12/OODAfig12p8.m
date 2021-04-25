disp('Running MATLAB script file OODAfig12p8.m') ;
%
%    Makes Figure 12.8 of the OODA book,
%    High Dimensional Gaussian Data
%    Illustrates Single Linkage Clusters
%
%    Copied from OODAbookChpKFigFHierHiD.m
%    in:        OODAbook\ChapterK
%

datafilestr = '..\..\DataSets\HighDimensionalGaussianData' ;


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


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Graphic for Single - Indiv & PC1
%
figure(1) ;
clf ;
  Z1 = linkage(mdata',linkparstr1,distparstr1) ;
      %  Construct Hierarchical Cluster Tree 
      %  Treating rows as data objects
  [H1,T1,OUTPERM1] = dendrogram(Z1,0,'ColorThreshold',colthresh1) ;
      %  plot full dendrogram

  %  Generate Corresponding Color Matrix
  %
  nh = length(H1) ;
      %  Number of line object handles
  mcolor = zeros(n,3) ;
      %  Initiate color matrix as all black
  for ih = 1:nh ;
    XData = get(H1(ih),'XData') ;
    YData = get(H1(ih),'YData') ;
    vcolor = get(H1(ih),'Color') ;
    if YData(1) == 0 ;    %  left end touches down, so Xdata gives index
      ind = OUTPERM1(XData(1)) ;
          %  index in original data set
      mcolor(ind,:) = vcolor ;
    end ;
    if YData(4) == 0 ;    %  right end touches down, so Xdata gives index
      ind = OUTPERM1(XData(4)) ;
          %  index in original data set
      mcolor(ind,:) = vcolor ;
    end ;
  end ;

mdir = [] ;
for i = 1:n ;
  if norm(mcolor(i,:) - [0 0 0]) == 0 ;    % this point labelled black
    mdir = [mdir (mdata(:,i) / norm(mdata(:,i)))] ;
        %  Direction vector in direction of this data point
  end ;
end ;
labelcellstr = {{'Outlier 1'; 'Outlier 2'; 'PC1 scores'}} ;
paramstruct = struct('npcadiradd',1, ...
                     'icolor',mcolor, ...
                     'isubpopkde',1, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,mdir,paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig12p8.png') ;



