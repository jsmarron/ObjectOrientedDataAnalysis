disp('Running MATLAB script file OODAfig4p4.m') ;
%
%    Makes Figure 4.4 of the OODA book,
%    Toy example for PCA in FDA, 50-d Double Arches
%    Scores Scatterplot Matrix View
%
%    Copied from OODAbookChpBFigJ.m
%    in:        OODAbook\ChapterB
%

datafilestr = '..\..\DataSets\TwinArchesData' ;
datastr = '2 Clusters, #2' ;


%  Read in data
%
mdata = xlsread(datafilestr) ;

d = size(mdata,1) ;
    %  dimension of each data curve
n = size(mdata,2) ;
    %  number of data curves


%  Generate graphics
%
figure(1) ;
clf ;

paramstruct = struct('npcadiradd',3, ...
                     'labelcellstr',{{'PC1 Scores'; 'PC2 Scores'; 'PC3 Scores'}}, ...
                     'iscreenwrite',1) ;
scatplotSM(mdata,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 11.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 10.5]) ; 
print('-dpng','OODAfig4p4.png') ;

