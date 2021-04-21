disp('Running MATLAB script file OODAfig4p6.m') ;
%
%    Makes Figure 4.6 of the OODA book,
%    PCA scores of log data curves from 2011 Lung Cancer Data
%
%    Copied from OODAbookChpBFigL.m
%    in:        OODAbook\ChapterB
%

datafilestr = '..\..\DataSets\LungCancerData' ;


%  Read in data
%
mdatl = xlsread(datafilestr) ;

d = size(mdatl,1) ;
    %  dimension of each data curve
n = size(mdatl,2) ;
    %  number of data curves


%  Make main graphics
%
nbp = size(mdatl,1) ;
paramstruct = struct('npcadiradd',2, ...
                     'labelcellstr',{{'PC1 Scores'; 'PC2 Scores'}}, ...
                     'iscreenwrite',1) ;
scatplotSM(mdatl,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p6.png') ;

