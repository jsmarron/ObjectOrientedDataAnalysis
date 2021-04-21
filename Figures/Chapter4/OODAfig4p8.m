disp('Running MATLAB script file OODAfig4p8.m') ;
%
%    Makes Figure 4.8 of the OODA book,
%    Raw log data curves from 2011 Lung Cancer Data, Next Gen Seq
%    Brushed colors
%
%    Copied from OODAbookChpBFigN.m
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
vibp = (1:nbp)' ;
vaxh = axisSM(vibp) ;
vaxv = axisSM(mdatl) ;
vaxv(1) = 0 ;

hold on ;
for i = 1:n ;
  if sum(mcolor(i,:)) > 0.5 ;
    plot(mdatl(:,i),'-','Color',mcolor(i,:)) ;
  end ;
end ;
hold off ;
xlabel('exonic nt number, not genomic position') ;
ylabel('log_{10}(RNA read depth + 1)') ;
axis([vaxh(1) vaxh(2) vaxv(1) vaxv(2)]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig4p8.png') ;

