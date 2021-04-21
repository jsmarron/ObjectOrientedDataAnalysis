disp('Running MATLAB script file OODAfig4p10.m') ;
%
%    Makes Figure 4.10 of the OODA book,
%    Pan Cancer Data, subsetted to 50 each from 6 types
%    DWD scores scatterplot matrix
%
%    Copied from OODAbookChpBFigR.m
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
mind = [[4 2]; [1 5]; [6 3]] ;
    %caCTnamebase = {'BLCA' 'KIRC' 'OV' 'HNSC' 'COAD' 'BRCA'} ;

%  Compute Directions etc.
%
mDWDdirn = [] ;
for irow = 1:size(mind,1) ;
  istart1 = 1 + 50 * (mind(irow,1) - 1) ;
  iend1 = 50 * mind(irow,1) ;
  istart2 = 1 + 50 * (mind(irow,2) - 1) ;
  iend2 = 50 * mind(irow,2) ;
  DWDdirn = DWD2XQ(mdata(:,istart1:iend1), ...
                   mdata(:,istart2:iend2)) ;
  mDWDdirn = [mDWDdirn DWDdirn] ;
end ;

figure(1) ;
clf ;
labelcellstr = {{[caCTnamebase{mind(1,1)} ' vs. ' caCTnamebase{mind(1,2)}]; ...
                 [caCTnamebase{mind(2,1)} ' vs. ' caCTnamebase{mind(2,2)}]; ...
                 [caCTnamebase{mind(3,1)} ' vs. ' caCTnamebase{mind(3,2)}]}} ;
mlegendcolor = mcolorbase ;
paramstruct = struct('npcadiradd',0, ...
                     'icolor',mcolor, ...
                     'markerstr',markerstr, ...
                     'isubpopkde',1, ...
                     'labelcellstr',labelcellstr, ...
                     'legendcellstr',{caCTnamebase}, ...
                     'mlegendcolor',mlegendcolor, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,mDWDdirn,paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p10.png') ;

