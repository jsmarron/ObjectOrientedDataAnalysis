disp('Running MATLAB script file OODAfig12p10.m') ;
%
%    Makes Figure 12.10 of the OODA book,
%    Mass Flux Data,  curvdat PCA
%
%    Copied from 
%    in:        OODAbook\ChapterK
%
 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic

datafilestr = '..\..\DataSets\MassFluxData' ;



if ipart == 0 ;    %  Generate and save data

  datfilename = ['..\..\..\..\Research\GitHubRepositories'  ...
                    '\Books\OODAbook\ChapterK\mflux.data'] ;

  %  Load Data
  %
  load(datfilename) ;
  mdata = mflux' ;
      %  put data vectors in columns
  mdata = mdata(1:42,:) ;

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;

  d = size(mdata,1) ;
  n = size(mdata,2) ;
  xgrid = (1:d)' ;


  %  Generate top row graphic
  % 
  figure(1) ;
  clf ;
  paramstruct = struct('viout',1, ...
                       'vipcplot',0, ...
                       'vicolplot',[1 2 3], ...
                       'icolor',0, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 3.5]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
  print('-dpng','OODAfig12p10A.png') ;


  %  Generate bottom row graphic
  % 
  figure(2) ;
  clf ;
  paramstruct = struct('viout',1, ...
                       'vipcplot',1, ...
                       'vicolplot',[1 2 4], ...
                       'icolor',0, ...
                       'iscreenwrite',1) ;
  curvdatSM(mdata,paramstruct) ;

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 3.5]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
  print('-dpng','OODAfig12p10B.png') ;


end ;

