disp('Running MATLAB script file PCAvstSNE.m') ;
%
%    Makes graphics comparing PCA and tSNE vsualizations
%    for the PanCan data from Figure 4.9 of the OODA book.
%    Copied from OODAfig4p9.m
%
%    Uses tSNe lines from OODAfig11p9.m
%    This uses Matlab implementation
%    May be different from original Matlab t-SNE software 
%             of Laurens van der Maaten, 2010, used in OODA book examples
%
%    Pan Cancer Data, subsetted to 50 each from 6 types
%
%    1st .png graphic is 4x4 PCA scatterplot matrix
%    2nd .png is single tSNE view (default perplexity)


%  Read in data
%
mdata = xlsread('..\..\DataSets\PanCancerData.xlsx','Sheet1','B3:KO12480') ;

d = size(mdata,1) ;
    %  dimension of each data curve
n = size(mdata,2) ;
    %  number of data curves


%  Set colors and markers
%
mcolorbase = RainbowColorsQY(6) ;
mcolorbase(5,:) = [0.8 0.8 0] ;
    %  Make Yellow color for COAD a bit darker
caCTnamebase = {'BLCA' 'KIRC' 'OV' 'HNSC' 'COAD' 'BRCA'} ;

mcolor = zeros(n,3) ;
markerstr = [] ;
for itype = 1:6 ;
  for id = 1:50 ;
    i = id + (itype - 1) * 50 ;
    if itype == 1 ;    %  BLCA
      mcolor(i,:) = mcolorbase(1,:) ;
      markerstr = strvcat(markerstr,'s') ;
    elseif itype == 2 ;    %  KIRC  
      mcolor(i,:) = mcolorbase(2,:) ;
      markerstr = strvcat(markerstr,'d') ;
    elseif itype == 3 ;    %  OV
      mcolor(i,:) = mcolorbase(3,:) ;
      markerstr = strvcat(markerstr,'x') ;
    elseif itype == 4 ;    %  HNSC
      mcolor(i,:) = mcolorbase(4,:) ;
      markerstr = strvcat(markerstr,'*') ;
    elseif itype == 5 ;    %  COAD
      mcolor(i,:) = mcolorbase(5,:) ;
      markerstr = strvcat(markerstr,'+') ;
    elseif itype == 6 ;    %  BRCA
      mcolor(i,:) = mcolorbase(6,:) ;
      markerstr = strvcat(markerstr,'o') ;
    end ;
  end ;
end ;


%  Make Main PCA Graphic
%
figure(1) ;
clf ;
labelcellstr = {{'PC 1 Scores' 'PC 2 Scores' 'PC 3 Scores' 'PC 4 Scores'}} ;
paramstruct = struct('npcadiradd',4, ...
                     'icolor',mcolor, ...
                     'markerstr',markerstr, ...
                     'isubpopkde',1, ...
                     'legendcellstr',{caCTnamebase}, ...
                     'mlegendcolor',mcolorbase, ...
                     'ibelowdiag',1, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,[],paramstruct) ;

%  Create png file
%
printSM('PanCan-PCA.png',2) ;


%  Make main tSNE Graphic
%
figure(2) ;
clf ;

left = 0 ;
right = 1 ;
bottom = 0; 
top = 1 ;
ms = 8 ;
lw = 1 ;
fs = 10 ;

perp = 30 ;
%mappedX = tsne(mdata',[],2,2,perp) ;
mappedX = tsne(mdata') ;
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

%  Create png file
%
printSM('PanCan-tSNE.png',2) ;



