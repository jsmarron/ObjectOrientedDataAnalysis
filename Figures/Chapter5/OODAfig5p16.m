disp('Running MATLAB script file OODAfig5p16.m') ;
%
%    Makes Figure 5.16 of the OODA book,
%    Pan Cancer Data, subsetted to 50 each from 6 types
%    Shows impact of log transformation
%
%    Copied from OODAbookChpDFigL.m
%    in:        OODAbook\ChapterD
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


legendcellstr = {{'OV' 'UCEC'}} ;
mlegendcolor = [[1 0 1]; ...
                [0 0.7 0]] ;


%  Find data reduced to 1000 most variable genes and consider transformations
%      using lines from PanCan2.m
vsd = std(mdata,0,2) ;
[temp, vind] = sort(vsd,'descend') ;
mdata = mdata(vind(1:1000),:) ;

mdataR = 2.^mdata ;
    %  Inverse of log2 transform

disp('Starting Shifted log transformations') ;
mdataT = AutoTransQF(mdataR) ;
disp('Transformations finished') ;
    %  auto log transformed version


%  Focus on OV and UCEC
%
mdataROVs = mdataR(:,61:90) ;
mdataRUCECs = mdataR(:,61:90) ;



%  Big problem:  Different subset of Pancan data.  Looksl like need to have two such data sets...
 


%  Set graphics
%
figure(1) ;
clf ;


subplot(3,3,1) ;    %  Raw PC12
paramstruct = struct('npc',2,...
                     'iscreenwrite',1,...
                     'viout',[0 0 0 0 1 0 0 0 1]) ;
outstruct = pcaSM([mdataROVs mdataRUCECs],paramstruct) ;
mpc = getfield(outstruct,'mpc') ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'xlabelstr','PC1 Scores', ...
                     'ylabelstr','PC2 Scores', ...
                     'iscreenwrite',1) ;
projplot2SM(mpc,eye(2),paramstruct) ;


subplot(3,3,2) ;    %  Raw PC12 - zoomed axes
vaxlim = [-1.9 2.5 -1.3 2.1] * 10^5 ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'vaxlim',vaxlim, ...
                     'xlabelstr','PC1 Scores', ...
                     'ylabelstr','PC2 Scores', ...
                     'iscreenwrite',1) ;
projplot2SM(mpc,eye(2),paramstruct) ;


subplot(3,3,3) ;    %  log2 PC12
paramstruct = struct('npc',2,...
                     'iscreenwrite',1,...
                     'viout',[0 0 0 0 1 0 0 0 1]) ;
outstruct = pcaSM([mdataOVs mdataUCECs],paramstruct) ;
mpc = getfield(outstruct,'mpc') ;
vpropSSmrlog2 = getfield(outstruct,'vpropSSmr') ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'xlabelstr','PC1 Scores', ...
                     'ylabelstr','PC2 Scores', ...
                     'iscreenwrite',1) ;
projplot2SM(mpc,eye(2),paramstruct) ;


subplot(3,3,4) ;    %  Raw MD
MDraw = mean(mdataROVs,2) - mean(mdataRUCECs,2) ;
MDraw = MDraw / norm(MDraw) ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'isubpopkde',1, ...
                     'xlabelstr','MD Scores', ...
                     'iscreenwrite',1) ;
projplot1SM([mdataROVs mdataRUCECs],MDraw,paramstruct) ;


subplot(3,3,5) ;    %  Raw MD - zoomed axes
vaxlim = [-2.8 1.1] * 10^5 ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'isubpopkde',1, ...
                     'vaxlim',vaxlim, ...
                     'xlabelstr','MD Scores', ...
                     'iscreenwrite',1) ;
projplot1SM([mdataROVs mdataRUCECs],MDraw,paramstruct) ;


subplot(3,3,6) ;    %  log2 MD
MDlog2 = mean(mdataOVs,2) - mean(mdataUCECs,2) ;
MDlog2 = MDlog2 / norm(MDlog2) ;
paramstruct = struct('icolor',icolors, ...
                     'markerstr',markerstrs, ...
                     'isubpopkde',1, ...
                     'xlabelstr','MD Scores', ...
                     'iscreenwrite',1) ;
projplot1SM([mdataOVs mdataUCECs],MDlog2,paramstruct) ;


subplot(3,3,7) ;    %  Raw ROC
paramstruct = struct('xlabelstr','P{OV <= testpoint}', ...
                     'ylabelstr','P{UCEC <= testpoint}') ;
ROCcurveSM(mdataROVs' * MDraw, mdataRUCECs' * MDraw, paramstruct) ;


subplot(3,3,9) ;    %  log2 ROC
paramstruct = struct('xlabelstr','P{OV <= testpoint}', ...
                     'ylabelstr','P{UCEC <= testpoint}') ;
ROCcurveSM(mdataOVs' * MDlog2, mdataUCECs' * MDlog2, paramstruct) ;


orient portrait ;
set(gcf,'PaperSize',[7.0, 7.0]) ; 
set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 6.5]) ; 
%print('-depsc2', [pstr '.eps']) ;
print('-depsc2','-cmyk',[pstr 'CMYK.eps']) ;


%  Output numbers for table as .xls file
%
xlssavestr = [pstr '.xlsx'] ;
xlswrite(xlssavestr,{'Output from OODAbookChpDFigL.m'},'Outputs','A1') ;
xlswrite(xlssavestr,{'For Table of % Variation Explained by 1st 2 PCA components'},'Outputs','A2') ;
xlswrite(xlssavestr,{'PC1'},'Outputs','B3') ;
xlswrite(xlssavestr,{'PC2'},'Outputs','C3') ;
xlswrite(xlssavestr,{'Raw Data'},'Outputs','A4') ;
xlswrite(xlssavestr,{'log2 Data'},'Outputs','A5') ;

xlswrite(xlssavestr,100 * vpropSSmr(1),'Outputs','B4') ;
xlswrite(xlssavestr,100 * vpropSSmr(2),'Outputs','C4') ;
xlswrite(xlssavestr,100 * vpropSSmrlog2(1),'Outputs','B5') ;
xlswrite(xlssavestr,100 * vpropSSmrlog2(2),'Outputs','C5') ;


pauseSM


%  Run DiProPerms, to get p-values
%  Keep graphics for later reference
%
figure(2) ;
clf ;
savestr = [pstr '-RawDiProPerm'] ;
title2str = ['Raw PanCan, n1 = n2 = ' num2str(nsubset)  ',  d = ' num2str(d)] ;
paramstruct = struct('idir',2, ...
                     'nsim',100, ...
                     'nreport',5, ...
                     'seed',seed, ...
                     'icolor',mlegendcolor, ...
                     'markerstr',['o'; '+'], ...
                     'title1str','Mean Diff DiProPerm OV & UCEC', ...
                     'title2str',title2str, ...
                     'savestr',savestr, ...
                     'iscreenwrite',1) ;
DiProPermSM(mdataROVs,mdataRUCECs,paramstruct) ;

figure(3) ;
clf ;
savestr = [pstr '-Log2DiProPerm'] ;
title2str = ['Log2 PanCan, n1 = n2 = ' num2str(nsubset)  ',  d = ' num2str(d)] ;
paramstruct = struct('idir',2, ...
                     'nsim',100, ...
                     'nreport',5, ...
                     'seed',seed, ...
                     'icolor',mlegendcolor, ...
                     'markerstr',['o'; '+'], ...
                     'title1str','Mean Diff DiProPerm OV & UCEC', ...
                     'title2str',title2str, ...
                     'savestr',savestr, ...
                     'iscreenwrite',1) ;
DiProPermSM(mdataOVs,mdataUCECs,paramstruct) ;




%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig5p16.png') ;

