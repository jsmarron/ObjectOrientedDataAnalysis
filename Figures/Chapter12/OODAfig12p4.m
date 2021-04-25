disp('Running MATLAB script file OODAfig12p4.m') ;
%
%    Makes Figure 12.4 of the OODA book,
%    Four Cluster data, illustrating dendrogram for single linkage, Eudlidean distance
%
%    Copied from OODAbookChpKFigEDendroEucSing.m
%    in:        OODAbook\ChapterK
%

datafilestr = '..\..\DataSets\FourClusterData' ;

nc1 = 60 ;
nc2 = 30 ;
nc3 = 30 ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Make main graphic
%
figure(1) ;
clf ;

n = size(mdata,2) ;


%Generate Graphics
%
Z = linkage(mdata','single','euclidean') ;
    %  Construct Hierarchical Cluster Tree 
dendrogram(Z,0,'ColorThreshold',0.07) ;
    %  plot full dendrogram
axis off ;

vachil = get(gca,'Children') ;
nachil = length(vachil) ;
vclusti = [] ;
for iac = 1:nachil ;
  curcolor = get(vachil(iac),'Color') ;
  if norm(curcolor - [1 0 0]) == 0 ;
                       %  Currently red (biggest cluster)
    set(vachil(iac),'Color',[0 1 0]) ;  %  Turn green
    vclusti = [vclusti; 1] ;

  elseif norm(curcolor - [0.5 0 1]) == 0 ;  
                       %  Currently blue (circles)
    set(vachil(iac),'Color',[0 0 1]) ;  %  Turn blue
    vclusti = [vclusti; 2] ;

  elseif norm(curcolor - [0.5 1 0]) == 0 ;
                       %  Currently green (squares)
    set(vachil(iac),'Color',[0 1 1]) ;  %  Turn cyan
    vclusti = [vclusti; 3] ;

  elseif norm(curcolor - [0 1 1]) == 0 ;
                       %  Currently cyan (outliers)
    set(vachil(iac),'Color',[1 0 0]) ;  %  Turn red
    vclusti = [vclusti; 4] ;

  else ;
    set(vachil(iac),'Color',[0 0 0]) ;  %  Turn black
    vclusti = [vclusti; 0] ;

  end ;

end ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig12p4.png') ;



