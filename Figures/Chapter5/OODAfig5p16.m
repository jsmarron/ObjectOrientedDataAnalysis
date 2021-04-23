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

ipart = 0 ;    %  0 - Collect and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\PanCancerData2' ;



if ipart == 0 ;    %  Collect and save data

  %  Load Data
  %
  infilestr = '..\..\..\..\Research\Bioinf\GeneArray\TCGA-PanCan\PanCan2.mat' ;
  load('infilestr') ;
      %    Loads Variables:
      %        mdata          Matrix of Gene Expression
      %        caGeneName     cell array of Gene Names 
      %        vOVflag        Indicator of OV cases (others are UCEC)
      %        mdataR         Matrix of Gene Expression (Raw coubts scale)
      %        mdataT         Matrix of Gene Expression (Auto transformed)

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





  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 12.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
  print('-dpng','OODAfig5p16.png') ;


end ;
