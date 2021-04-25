disp('Running MATLAB script file OODAfig12p3.m') ;
%
%    Makes Figure 12.3 of the OODA book,
%    Four Cluster data, illustrating k-means
%
%    Copied from OODAbookChpKFigBkMeans.m
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
for ip = 1:4 ;
  subplot(2,2,ip) ;
  vcid = kmeans(mdata',ip+1) ;
  mcolorc = [] ;
  if ip == 1 ;
    for i = 1:n ;
      if vcid(i) == 1 ;
        mcolorc = [mcolorc; [1 0.5 1]] ;
      elseif vcid(i) == 2 ;
        mcolorc = [mcolorc; [0 1 0]] ;
      end ;
    end ;
    n1 = sum(vcid' == 1) ;
    n2 = sum(vcid' == 2) ;
    mean1 = mean(mdata(:,vcid' == 1),2) ;
    mean2 = mean(mdata(:,vcid' == 2),2) ;
  elseif ip == 2 ;
    for i = 1:n ;
      if vcid(i) == 1 ;
        mcolorc = [mcolorc; [1 0 1]] ;
      elseif vcid(i) == 2 ;
        mcolorc = [mcolorc; [0 1 1]] ;
      elseif vcid(i) == 3 ;
        mcolorc = [mcolorc; [0 1 0]] ;
      end ;
    end ;
  elseif ip == 3 ;
    for i = 1:n ;
      if vcid(i) == 1 ;
        mcolorc = [mcolorc; [0.5 1 0.5]] ;
      elseif vcid(i) == 2 ;
        mcolorc = [mcolorc; [0 0.5 0]] ;
      elseif vcid(i) == 3 ;
        mcolorc = [mcolorc; [1 0 1]] ;
      elseif vcid(i) == 4 ;
        mcolorc = [mcolorc; [0 1 1]] ;
      end ;
    end ;
  elseif ip == 4 ;
    for i = 1:n ;
      if vcid(i) == 1 ;
        mcolorc = [mcolorc; [1 0 0]] ;
      elseif vcid(i) == 2 ;
        mcolorc = [mcolorc; [0 0.5 0]] ;
      elseif vcid(i) == 3 ;
        mcolorc = [mcolorc; [0 1 0]] ;
      elseif vcid(i) == 4 ;
        mcolorc = [mcolorc; [0 0.5 1]] ;
      elseif vcid(i) == 5 ;
        mcolorc = [mcolorc; [0.5 1 0.5]] ;
      end ;
    end ;
  end ;


  hold on ;
    for i = 1:n ;
      plot(mdata(1,i),mdata(2,i),markerstr(i),'Color',mcolorc(i,:), ...
                            'MarkerSize',marksize(i),'Linewidth',linewd(i)) ;
    end ;
  hold off ;
  title(['k = ' num2str(ip + 1)],'FontSize',15) ;
  axis equal ;
  axis off ;

end ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig12p3.png') ;



