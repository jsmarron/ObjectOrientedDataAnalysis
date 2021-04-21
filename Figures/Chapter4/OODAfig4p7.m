disp('Running MATLAB script file OODAfig4p7.m') ;
%
%    Makes Figure 4.7 of the OODA book,
%    PCA scores of log data curves from 2011 Lung Cancer Data
%    Brushed colors
%
%    Copied from OODAbookChpBFigM.m
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


%  Set up brushing colors
%
%  Based on initial PCA  
paramstruct = struct('npc',4,...      
                     'iscreenwrite',1,...                       
                     'viout',[0 0 0 0 1]) ;  
outstruct = pcaSM(mdatl,paramstruct) ;  
mpc = getfield(outstruct,'mpc') ;
mcolor = ones(n,1) * [0.6 0.4 0] ;      
    %  Enhanced base color
vflag = (mpc(1,:) > 0)' ;
mcolor(vflag,:) = ones(sum(vflag),1) * [0.8 0 0] ;
vflag = (mpc(2,:) > 4)' ;
mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 0.7] ;


%  Make main graphics
%
nbp = size(mdatl,1) ;
paramstruct = struct('npcadiradd',2, ...
                     'icolor',mcolor, ...
                     'isubpopkde',1, ...
                     'labelcellstr',{{'PC1 Scores'; 'PC2 Scores'}}, ...
                     'iscreenwrite',1) ;
scatplotSM(mdatl,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p7.png') ;

