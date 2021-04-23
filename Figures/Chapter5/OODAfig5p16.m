disp('Running MATLAB script file OODAfig5p16.m') ;
%
%    Makes Figure 5.16 of the OODA book,
%    Pan Cancer Data, subsetted to 50 each from just OV and UCEC
%                           (Ovarian and Uterine cancers)
%    Shows impact of log transformation
%
%    Copied from OODAbookChpDFigL.m
%    in:        OODAbook\ChapterD
%

ipart = 1 ;    %  0 - Collect and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\PanCancerData2' ;



if ipart == 0 ;    %  Collect and save data

  %  Load Data
  %
  infilestr = '..\..\..\..\Research\GithubRepositories\Books\OODAbook\ChapterD\PanCan2.mat' ;
  load(infilestr) ;
      %        mdata          Matrix of Gene Expression
      %        caGeneName     cell array of Gene Names 
      %        vOVflag        Indicator of OV cases (others are UCEC)
      %        mdataR         Matrix of Gene Expression (Raw counts scale)
      %        mdataT         Matrix of Gene Expression (Auto transformed)

  %  Note this input file is available on line at:
  %      https://marronwebfiles.sites.oasis.unc.edu/DataSets/TCGA/PanCan/PanCan2.mat

  xlswrite([datafilestr '.xlsx'],mdata,'mdata') ;
  xlswrite([datafilestr '.xlsx'],caGeneName,'caGeneName') ;
  xlswrite([datafilestr '.xlsx'],vOVflag,'vOVflag') ;
  xlswrite([datafilestr '.xlsx'],mdataR,'mdataR') ;
  xlswrite([datafilestr '.xlsx'],mdataT,'mdataT') ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr,'mdata') ;
  caGeneName = xlsread(datafilestr,'caGeneName') ;
  vOVflag = xlsread(datafilestr,'vOVflag') ;
  mdataR = xlsread(datafilestr,'mdataR') ;
  mdataT = xlsread(datafilestr,'mdataT') ;

  disp(' ') ;
  disp('    Data Read Finidhed') ;
  disp(' ') ;

  d = size(mdata,1) ;
  n = size(mdata,2) ;

  %  Create icolor & markerstr
  %
  icolor = [] ;
  markerstr = [] ;
  for i = 1:n ;
    if vOVflag(i) ;
      icolor = [icolor; [1 0 1]] ;
      markerstr = strvcat(markerstr,'o') ;
    else ;
      icolor = [icolor; [0 0.7 0]] ;
      markerstr = strvcat(markerstr,'+') ;
    end ;
  end ;

  legendcellstr = {{'OV' 'UCEC'}} ;
  mlegendcolor = [[1 0 1]; ...
                  [0 0.7 0]] ;


  nsubset = 30 ;

  seed = 0 ;
  rng(seed) ;

  vind = 1:n ;
  vindOV = vind(vOVflag) ;
  vindUCEC = vind(~vOVflag) ;
      %  overall indices in each type
  nOV = sum(vOVflag) ;
  nUCEC = sum(~vOVflag) ;
  vindOVs = vindOV(randperm(nOV,nsubset)) ;
  vindUCECs = vindUCEC(randperm(nUCEC,nsubset)) ;
      %  random subsets of overall indices

  mdataOVs = mdata(:,vindOVs) ;
  mdataROVs = mdataR(:,vindOVs) ;
  mdataTOVs = mdataT(:,vindOVs) ;
  mdataUCECs = mdata(:,vindUCECs) ;
  mdataRUCECs = mdataR(:,vindUCECs) ;
  mdataTUCECs = mdataT(:,vindUCECs) ;

  icolors = [(ones(nsubset,1) * mlegendcolor(1,:)); ...
            (ones(nsubset,1) * mlegendcolor(2,:))] ;

  markerstrs = [] ;
  markerstrs2 = [] ;
  for i = 1:nsubset ;
    markerstrs = strvcat(markerstrs,'o') ;
    markerstrs2 = strvcat(markerstrs2,'+') ;
  end ;
  markerstrs = strvcat(markerstrs,markerstrs2) ;


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


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig5p16A.png') ;


  %  Output numbers for table as .xls file
  %
  xlssavestr = 'OODAfig5p16.xlsx' ;
  xlswrite(xlssavestr,{'Output from OODAfig5p16.m'},'Outputs','A1') ;
  xlswrite(xlssavestr,{'For Table of % Variation Explained by 1st 2 PCA components'},'Outputs','A2') ;
  xlswrite(xlssavestr,{'PC1'},'Outputs','B3') ;
  xlswrite(xlssavestr,{'PC2'},'Outputs','C3') ;
  xlswrite(xlssavestr,{'Raw Data'},'Outputs','A4') ;
  xlswrite(xlssavestr,{'log2 Data'},'Outputs','A5') ;

  xlswrite(xlssavestr,100 * vpropSSmr(1),'Outputs','B4') ;
  xlswrite(xlssavestr,100 * vpropSSmr(2),'Outputs','C4') ;
  xlswrite(xlssavestr,100 * vpropSSmrlog2(1),'Outputs','B5') ;
  xlswrite(xlssavestr,100 * vpropSSmrlog2(2),'Outputs','C5') ;


  %  Run DiProPerms, to get p-values
  %  Keep graphics for later reference
  %
  figure(2) ;
  clf ;
  title2str = ['Raw PanCan, n1 = n2 = ' num2str(nsubset)  ',  d = ' num2str(d)] ;
  paramstruct = struct('idir',2, ...
                       'nsim',1000, ...
                       'nreport',5, ...
                       'seed',seed, ...
                       'icolor',mlegendcolor, ...
                       'markerstr',['o'; '+'], ...
                       'title1str','Mean Diff DiProPerm OV & UCEC', ...
                       'title2str',title2str, ...
                       'iscreenwrite',1) ;
  DiProPermSM(mdataROVs,mdataRUCECs,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig5p16B.png') ;


  figure(3) ;
  clf ;
  title2str = ['Log2 PanCan, n1 = n2 = ' num2str(nsubset)  ',  d = ' num2str(d)] ;
  paramstruct = struct('idir',2, ...
                       'nsim',1000, ...
                       'nreport',5, ...
                       'seed',seed, ...
                       'icolor',mlegendcolor, ...
                       'markerstr',['o'; '+'], ...
                       'title1str','Mean Diff DiProPerm OV & UCEC', ...
                       'title2str',title2str, ...
                       'iscreenwrite',1) ;
  DiProPermSM(mdataOVs,mdataUCECs,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig5p16C.png') ;


end ;

