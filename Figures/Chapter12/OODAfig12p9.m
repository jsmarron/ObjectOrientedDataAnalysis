disp('Running MATLAB script file OODAfig12p9.m') ;
%
%    Makes Figure 12.9 of the OODA book,
%    High Dimensional Gaussian Data
%    Illustrates Ward's Linkage Clusters
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


%  Graphic for Ward's - MDs & PC1
%
figure(2) ;
clf ;
  Z2 = linkage(mdata',linkparstr2,distparstr2) ;
      %  Construct Hierarchical Cluster Tree 
      %  Treating rows as data objects
  [H2,T2,OUTPERM2] = dendrogram(Z2,0,'ColorThreshold',colthresh2) ;

  %  Generate Corresponding Color Matrix
  %
  nh = length(H2) ;
      %  Number of line object handles
  mcolor = zeros(n,3) ;
      %  Initiate color matrix as all black
  for ih = 1:nh ;
    XData = get(H2(ih),'XData') ;
    YData = get(H2(ih),'YData') ;
    vcolor = get(H2(ih),'Color') ;
    if YData(1) == 0 ;    %  left end touches down, so Xdata gives index
      ind = OUTPERM2(XData(1)) ;
          %  index in original data set
      mcolor(ind,:) = vcolor ;
    end ;
    if YData(4) == 0 ;    %  right end touches down, so Xdata gives index
      ind = OUTPERM2(XData(4)) ;
          %  index in original data set
      mcolor(ind,:) = vcolor ;
    end ;
  end ;

[ucolor,IA,IC] = unique(mcolor,'Rows') ;
vmean1 = mean(mdata(:,(IC == 1)),2) - mean(mdata(:,(IC == 2)),2) ;
vmean1 = vmean1 / norm(vmean1) ;
vmean2 = mean(mdata(:,(IC == 3)),2) - mean(mdata(:,(IC == 4)),2) ;
vmean2 = vmean2 / norm(vmean2) ;
mdir = [vmean1 vmean2] ;
labelcellstr = {{'MD1: C - B'; 'MD2: G - R'; ...
                 'PC1 scores'}} ;
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
print('-dpng','OODAfig12p9.png') ;



