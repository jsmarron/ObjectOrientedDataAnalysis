disp('Running MATLAB script file OODAfig4p9.m') ;
%
%    Makes Figure 4.9 of the OODA book,
%    Pan Cancer Data, subsetted to 50 each from 6 types
%    PCA scores scatterplot matrix
%
%    Copied from OODAbookChpBFigQ.m
%    in:        OODAbook\ChapterB
%


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


%  Make Main Graphics
%
figure(1) ;
clf ;
labelcellstr = {{'PC 1 Scores' 'PC 2 Scores' 'PC 3 Scores'}} ;
paramstruct = struct('npcadiradd',3, ...
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
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p9.png') ;

