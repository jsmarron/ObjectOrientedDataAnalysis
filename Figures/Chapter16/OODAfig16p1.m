disp('Running MATLAB script file OODAfig16p1.m') ;
%
%    Makes Figure 16.1 of the OODA book,
%    Outlier Toy Examples - Mean & PCA
%
%    Copied from OODAbookChpOFigAOutliersEg.m
%    in:        OODAbook\ChapterO
%

%  Set Parameters
%
left = -4 ;
right = 4 ;
bottom = -4 ;
top = 4 ;
lw1 = 1 ;   %  Line Width for Regular Data
lw2 = 1.5 ;    %  Line Width for Means
lw3 = 4 ;    %  Line Width for PC Directions
ss2 = 6 ; 

n1 = 10 ;
n2 = 40 ;
sig1 = 1 ;
sig1s = 0.15 ;
sig2 = 0.7 ;
sig2s = 0.3 ;

%  Generate Data
%
seed1 = 38726855 ;
rng(seed1) ;
mdata1 = 2 + sig1 * randn(1,n1) ;
mdata1 = [mdata1; mdata1 - 4 + sig1s * randn(1,n1)] ;
mdata1(:,10) = [-3; 3] ;
vmean1 = mean(mdata1,2) ;

seed2 = 11285189 ;
seed2 = 11285341 ;
rng(seed2) ;
mdata2 = -2 + sig2 * randn(1,n2) ;
mdata2 = [mdata2; -mdata2 - 4 + sig2s * randn(1,n2)] ;
mdata2(:,10) = [3; 3] ;
paramstruct = struct('npc',2, ...
                     'viout',[0 1 1], ...
                     'iscreenwrite',1) ;
outstruct = pcaSM(mdata2,paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;
vmean2 = getfield(outstruct,'vmean') ;


if sum(mdata2(1,:) < -4) > 0 ;
  disp('Have data with x < -4') ;
end ;
if sum(mdata2(2,:) < -4) > 0 ;
  disp('Have data with y < -4') ;
end ;


%  Make graphic
%
figure(1) ;
clf ;
subplot(1,2,1) ;    %  Outliers pull off mean
  plot(mdata1(1,:),mdata1(2,:),'k+','LineWidth',lw1) ;
  hold on ;
    plot(vmean1(1,:),vmean1(2,:),'k+','LineWidth',lw2,'MarkerSize',ss2) ;
    plot(vmean1(1,:),vmean1(2,:),'ko','LineWidth',lw2,'MarkerSize',ss2) ;
  hold off ;
  axis([left right bottom top]) ;
  axis square ;


subplot(1,2,2) ;    %  Outliers pull off PCA
  plot(mdata2(1,:),mdata2(2,:),'k+','LineWidth',lw1) ;
  hold on ;
    plot([vmean2(1,:); (vmean2(1,:) + 2.3 * meigvec(1,1))], ...
         [vmean2(2,:); (vmean2(2,:) + 2.3 * meigvec(1,2))], ...
             'k--','LineWidth',lw3) ;
    plot([vmean2(1,:); (vmean2(1,:) + 1.0 * meigvec(2,1))], ...
         [vmean2(2,:); (vmean2(2,:) + 1.0 * meigvec(2,2))], ...
             'k--','LineWidth',lw3) ;
  hold off ;
  axis([left right bottom top]) ;
  axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig16p1.png') ;



