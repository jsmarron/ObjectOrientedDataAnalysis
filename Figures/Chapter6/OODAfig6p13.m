disp('Running MATLAB script file OODAfig6p13.m') ;
%
%    Makes Figure 6.13 of the OODA book,
%    Lung Cancer data, expore centering
%
%    Copied from OODAbookChpFFigGlungCancerCentered.m
%    in:        OODAbook\ChapterF
%
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
%  Set up Brushed Color Matrix  
%  
%mcolor = ones(n,1) * [0 0 0] ;      
    %  Start with all black and update  
mcolor = ones(n,1) * [0.6 0.4 0] ;      
    %  Enhanced base color
ig = 2 ;    %  for Chromosome 9 = CDK2NA
if ig == 1 ;
  vflag = (mpc(2,:) < -10)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [1 0 0] ;
  vflag = (mpc(2,:) > 11)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 1] ;
elseif ig == 2 ;    
  vflag = (mpc(1,:) > 0)' ;
%  mcolor(vflag,:) = ones(sum(vflag),1) * [1 0 0] ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [0.8 0 0] ;
  vflag = (mpc(2,:) > 4)' ;
%  mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 1] ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 0.7] ;
elseif ig == 3 ;
  vflag = (mpc(1,:) > 70)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [1 0 0] ;
  vflag = (mpc(3,:) < -11)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 1] ;
elseif ig == 4 ;
  vflag = (mpc(2,:) > 4)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [0 0 1] ;
  vflag = (mpc(1,:) > 60)' ;
  mcolor(vflag,:) = ones(sum(vflag),1) * [1 0 0] ;
end ;


subplot(1,2,1) ;    %  Do column object mean adjustment

  mdatl2 = mdatl - (mean(mdatl,2) * ones(1,n)) ;

  nbp = size(mdatl2,1) ;
  vibp = (1:nbp)' ;
  vaxh = axisSM(vibp) ;
  vaxv = axisSM(mdatl2) ;

  %plot(mdatl2,'k-') ;
  hold on ;
  for i = 1:n ;
    if sum(mcolor(i,:)) > 0.5 ;
      plot(mdatl2(:,i),'-','Color',mcolor(i,:)) ;
    end ;
  end ;
  hold off ;
  %title('Gene = CDKN2A') ;
  xlabel('exonic nt number, not genomic position') ;
  ylabel('log_{10}(RNA read depth + 1)') ;
  axis([vaxh(1) vaxh(2) vaxv(1) vaxv(2)]) ;


subplot(1,2,2) ;    %  Do row object mean adjustment

  mdatl3 = mdatl2 - (ones(nbp,1) * mean(mdatl2,1)) ;

  vaxv = axisSM(mdatl3) ;

  %plot(mdat3,'k-') ;
  hold on ;
  for i = 1:n ;
    if sum(mcolor(i,:)) > 0.5 ;
      plot(mdatl3(:,i),'-','Color',mcolor(i,:)) ;
    end ;
  end ;
  hold off ;
  %title('Gene = CDKN2A') ;
  xlabel('exonic nt number, not genomic position') ;
  ylabel('log_{10}(RNA read depth + 1)') ;
  axis([vaxh(1) vaxh(2) vaxv(1) vaxv(2)]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig6p13.png') ;



