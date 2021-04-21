disp('Running MATLAB script file OODAfig4p12.m') ;
%
%    Makes Figure 4.12 of the OODA book,
%    Overlapping Classes Data
%    PCA scatterplot matrix
%
%    Copied from OODAbookChpBFigS.m
%    in:        OODAbook\ChapterB
%


ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\OverlappingClassesData' ;

n1 = 50 ;
n2 = 50 ;


if ipart == 0 ;    %  Generate and save data

  d = 1000 ;
  rng(29374557) ;
  mdata = randn(d,n1 + n2) ;

  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;

  mcolor = [(ones(n1,1) * [1 0 0]); ...
            (ones(n2,1) * [0 0 1])] ;
  markerstr = [] ;
  for i = 1:n1 ;
    markerstr = strvcat(markerstr,'+') ;
  end ;
  for i = 1:n2 ;
    markerstr = strvcat(markerstr,'o') ;
  end ;


  %  Make main graphics
  %
  figure(1) ;
  clf ;
  labelcellstr = {{'PC 1 Scores'; 'PC 2 Scores'; 'PC 3 Scores'}} ;
  paramstruct = struct('npcadiradd',3, ...
                       'icolor',mcolor, ...
                       'markerstr',markerstr, ...
                       'isubpopkde',1, ...
                       'labelcellstr',labelcellstr, ...
                       'iscreenwrite',1) ;
  scatplotSM(mdata,[],paramstruct) ;


  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 10.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
  print('-dpng','OODAfig4p12.png') ;


end ;

