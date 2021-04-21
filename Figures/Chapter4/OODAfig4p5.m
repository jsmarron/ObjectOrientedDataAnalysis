disp('Running MATLAB script file OODAfig4p5.m') ;
%
%    Makes Figure 4.5 of the OODA book,
%    Raw log data curves from 2011 Lung Cancer Data, Next Gen Seq
%
%    Copied from OODAbookChpBFigK.m
%    in:        OODAbook\ChapterB
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\LungCancerData' ;


if ipart == 0 ;    %  Read in and save data

  datfilename = ['..\..\..\..\Research\GitHubRepositories'  ...
                    '\Books\OODAbook\ChapterB\LungCancer2011'] ;

  %  Load data from .mat file
  %
  load(datfilename) ;
      %  Loads variables:
      %      DataS
      %      CaseNamesS
      %      vchrom
      %      GeneNamesS

  %  Set basics
  %
  ig = 2 ;    %  for Chromosome 9 = CDK2NA
  n = length(CaseNamesS) ;

  mdat = DataS{ig,2} ;
      %  raw data, for gene CDKN2A

  mdatl = log10(mdat + 1) ;

  xlswrite([datafilestr '.xlsx'],mdatl,'log10data') ;
  xlswrite([datafilestr '.xlsx'],CaseNamesS,'CaseNames') ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdatl = xlsread(datafilestr) ;

  d = size(mdatl,1) ;
      %  dimension of each data curve
  n = size(mdatl,2) ;
      %  number of data curves

  figure(1) ;
  clf ;


  %  Make main graphics
  %
  nbp = size(mdatl,1) ;
  vibp = (1:nbp)' ;
  vaxh = axisSM(vibp) ;
  vaxv = axisSM(mdatl) ;
  vaxv(1) = 0 ;
  plot(mdatl,'-') ;
  %title('Gene = CDKN2A') ;
  xlabel('exonic nt number, not genomic position') ;
  ylabel('log_{10}(RNA read depth + 1)') ;
  axis([vaxh(1) vaxh(2) vaxv(1) vaxv(2)]) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[7.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
  print('-dpng','OODAfig4p5.png') ;


end ;

