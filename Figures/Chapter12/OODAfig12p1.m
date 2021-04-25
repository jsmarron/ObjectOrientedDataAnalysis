disp('Running MATLAB script file OODAfig12p1.m') ;
%
%    Makes Figure 12.1 of the OODA book,
%    Four Cluster 2-d Toy Data
%    and illustration of within and total sums of squares
%
%    Copied from OODAbookChpKFigAClustersToy.m
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

mcolor = ones(nc1,1) * [0 1 0] ;
mcolor = [mcolor; (ones(nc2,1) * [0 0 1])] ;
mcolor = [mcolor; (ones(nc3,1) * [0 1 1])] ;
mcolor = [mcolor; [1; 1] * [1 0 0]] ;

markerstr = [] ;
marksize = [] ;
linewd = [] ;
for i = 1:nc1 ;
  markerstr = strvcat(markerstr,'+') ;
  marksize = [marksize; 6] ;
  linewd = [linewd; 1] ;
end ;
for i = 1:nc2 ;
  markerstr = strvcat(markerstr,'o') ;
  marksize = [marksize; 5] ;
  linewd = [linewd; 0.8] ;
end ;
for i = 1:nc3 ;
  markerstr = strvcat(markerstr,'s') ;
  marksize = [marksize; 6] ;
  linewd = [linewd; 1] ;
end ;
markerstr = strvcat(markerstr,'x') ;
markerstr = strvcat(markerstr,'x') ;
marksize = [marksize; 8] ;
marksize = [marksize; 8] ;
linewd = [linewd; 1.2] ;
linewd = [linewd; 1.2] ;

left = 0 ;
right = 1 ;
bottom = 0; 
top = 1 ;


%Generate Graphics
%
axis([left right bottom top]) ;
hold on ;
  for i = 1:n ;
    plot(mdata(1,i),mdata(2,i),markerstr(i),'Color',mcolor(i,:), ...
                          'MarkerSize',marksize(i),'Linewidth',linewd(i)) ;
  end ;
hold off ;
%title('Raw Cluster Data','FontSize',15) ;
axis equal ;
axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig12p1A.png') ;


%  Make 2nd panel
%
CIx1 = [-0.9; -0.4; -0.2] ;
CIy1 = [0.6; 0.3; 0.9] ;
CIx2 = [0.3; 0.5; 0.8; 0.9] ;
CIy2 = [0.8; 0.1; 0.6; 0.3] ;
meanx1 = mean(CIx1) ;
meany1 = mean(CIy1) ;
meanx2 = mean(CIx2) ;
meany2 = mean(CIy2) ;
meanxoa = mean([CIx1; CIx2]) ;
meanyoa = mean([CIy1; CIy2]) ;


subplot(2,1,1) ;
  axis([-3 1 0 1]) ;
  plot(CIx1,CIy1,'rs') ;
  hold on ;
    plot(CIx2,CIy2,'b*') ;
    plot(-1.9,0.5,'+','Color',[0.99 0.99 0.99]) ;
        %  put this on right side, nearly white keeps it from showing up
    plot([CIx1'; (meanx1 * ones(1,3))],[CIy1'; (meany1 * ones(1,3))],'r-') ;
    plot([CIx2'; (meanx2 * ones(1,4))],[CIy2'; (meany2 * ones(1,4))],'b-') ;
    plot(meanx1,meany1,'ro','MarkerSize',2,'LineWidth',2) ;
    plot(meanx2,meany2,'bo','MarkerSize',2,'LineWidth',2) ;
  hold off ;
  axis off ;

subplot(2,1,2) ;
  axis([-3 1 0 1]) ;
  plot(CIx1,CIy1,'rs') ;
  hold on ;
    plot(CIx2,CIy2,'b*') ;
    plot(-1.9,0.5,'+','Color',[0.99 0.99 0.99]) ;
        %  put this on right side, nearly white keeps it from showing up
    plot([CIx1'; (meanxoa * ones(1,3))],[CIy1'; (meanyoa * ones(1,3))],'k-') ;
    plot([CIx2'; (meanxoa * ones(1,4))],[CIy2'; (meanyoa * ones(1,4))],'k-') ;
    plot(meanxoa,meanyoa,'ko','MarkerSize',2,'LineWidth',2) ;
  hold off ;
  axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 6.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 5.5]) ; 
print('-dpng','OODAfig12p1B.png') ;



