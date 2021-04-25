disp('Running MATLAB script file OODAfig11p9.m') ;
%
%    Makes Figure 11.9 of the OODA book,
%    Four Cluster 2-d Toy Data
%    Illustrates t-SNE
%
%    Copied from OODAbookChpJFigLtSNE.m
%    in:        OODAbook\ChapterJ
%
%    This uses the Matlab t-SNE software of Laurens van der Maaten, 2010
%    Must be in the Matlab path

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

mcolor = ones(nc1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(nc2,1) * [0 0 1])] ;
mcolor = [mcolor; (ones(nc3,1) * [0 1 1])] ;
mcolor = [mcolor; [1; 1] * [1 0 0]] ;

markerstr = [] ;
for i = 1:nc1 ;
  markerstr = strvcat(markerstr,'+') ;
end ;
for i = 1:nc2 ;
  markerstr = strvcat(markerstr,'o') ;
end ;
for i = 1:nc3 ;
  markerstr = strvcat(markerstr,'s') ;
end ;
markerstr = strvcat(markerstr,'x') ;
markerstr = strvcat(markerstr,'x') ;

left = 0 ;
right = 1 ;
bottom = 0; 
top = 1 ;

TSNElabels = [ones(nc1,1); (2 * ones(nc2,1)); (3 * ones(nc3,1)); 4; 4] ;
ms = 8 ;
lw = 1 ;
fs = 10 ;


subplot(1,3,1) ;    %  TSNE, perp = 12
  perp = 12 ;
%  tsne(mdata',TSNElabels,2,2,perp) ;  
  mappedX = tsne(mdata',[],2,2,perp) ;
      %  empty input requests no graphics  
  mdataplot = mappedX' ;
  mdataplot(1,:) = mdataplot(1,:) - min(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) - min(mdataplot(2,:)) ;
      %  set smallest values to 0
  mdataplot(1,:) = mdataplot(1,:) / max(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) / max(mdataplot(2,:)) ;
      %  set largest values to 1

  axis([left right bottom top]) ;
  hold on ;
    for i = 1:n ;
      plot(mdataplot(1,i),mdataplot(2,i),markerstr(i),'Color',mcolor(i,:), ...
                            'MarkerSize',ms,'Linewidth',lw) ;
    end ;
  hold off ;
  title(['t-SNE, Perplexity = ' num2str(perp)],'FontSize',fs) ;
  axis equal ;
  axis off ;

subplot(1,3,2) ;    %  TSNE, perp = 30
  perp = 30 ;
%  tsne(mdata',TSNElabels,2,2,perp) ;  
  mappedX = tsne(mdata',[],2,2,perp) ;
      %  empty input requests no graphics  
  mdataplot = mappedX' ;
  mdataplot(1,:) = mdataplot(1,:) - min(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) - min(mdataplot(2,:)) ;
      %  set smallest values to 0
  mdataplot(1,:) = mdataplot(1,:) / max(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) / max(mdataplot(2,:)) ;
      %  set largest values to 1

  axis([left right bottom top]) ;
  hold on ;
    for i = 1:n ;
      plot(mdataplot(1,i),mdataplot(2,i),markerstr(i),'Color',mcolor(i,:), ...
                            'MarkerSize',ms,'Linewidth',lw) ;
    end ;
  hold off ;
  title(['t-SNE, Perplexity = ' num2str(perp)],'FontSize',fs) ;
  axis equal ;
  axis off ;


subplot(1,3,3) ;    %  TSNE, perp = 60
  perp = 60 ;
%  tsne(mdata',TSNElabels,2,2,perp) ;  
  mappedX = tsne(mdata',[],2,2,perp) ;
      %  empty input requests no graphics  
  mdataplot = mappedX' ;
  mdataplot(1,:) = mdataplot(1,:) - min(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) - min(mdataplot(2,:)) ;
      %  set smallest values to 0
  mdataplot(1,:) = mdataplot(1,:) / max(mdataplot(1,:)) ;
  mdataplot(2,:) = mdataplot(2,:) / max(mdataplot(2,:)) ;
      %  set largest values to 1

  axis([left right bottom top]) ;
  hold on ;
    for i = 1:n ;
      plot(mdataplot(1,i),mdataplot(2,i),markerstr(i),'Color',mcolor(i,:), ...
                            'MarkerSize',ms,'Linewidth',lw) ;
    end ;
  hold off ;
  title(['t-SNE, Perplexity = ' num2str(perp)],'FontSize',10) ;
  axis equal ;
  axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig11p9.png') ;



