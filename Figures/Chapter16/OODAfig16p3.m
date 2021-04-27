disp('Running MATLAB script file OODAfig16p3.m') ;
%
%    Makes Figure 16.3 of the OODA book,
%    Outlier Toy Examples - L1 Mean & SphericalPCA
%
%    Copied from OODAbookChpOFigBOutliersnEsts.m
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
r = 1.5 ;    %  radius of circles
nt = 201 ;
vtheta = linspace(0,2 * pi,nt) ;
mucircle = r * [cos(vtheta); sin(vtheta)] ;

%  Generate Data
%
seed1 = 38726855 ;
rng(seed1) ;
mdata1 = 2 + sig1 * randn(1,n1) ;
mdata1 = [mdata1; mdata1 - 4 + sig1s * randn(1,n1)] ;
mdata1(:,10) = [-3; 3] ;
vmean1 = mean(mdata1,2) ;

rmean1 = rmeanSM(mdata1') ;
    %  Note this function treats rows as data objects
rmean1 = rmean1' ;
mresrm1 = mdata1 - (rmean1 * ones(1,n1)) ;
vlengths = sqrt(diag(mresrm1' * mresrm1)) ;
mresrm1s = r * mresrm1 ./ (ones(2,1) * vlengths') ; 
    %  scaled version of data, lying on rmean1 centered circle

p1 = [1; 2] ;
mresp1 = mdata1 - (p1 * ones(1,n1)) ;
vlengths = sqrt(diag(mresp1' * mresp1)) ;
mresp1s = r * mresp1 ./ (ones(2,1) * vlengths') ; 
    %  scaled version of data, lying on p1 centered circle

meanp1 = p1 + mean(mresp1s,2) ;


seed2 = 11285189 ;
seed2 = 11285341 ;
rng(seed2) ;
mdata2 = -2 + sig2 * randn(1,n2) ;
mdata2 = [mdata2; -mdata2 - 4 + sig2s * randn(1,n2)] ;
mdata2(:,10) = [3; 3] ;

rmean2 = rmeanSM(mdata2') ;
    %  Note this function treats rows as data objects
rmean2 = rmean2' ;
mresrm2 = mdata2 - (rmean2 * ones(1,n2)) ;
vlengths = sqrt(diag(mresrm2' * mresrm2)) ;
mresrm2s = r * mresrm2 ./ (ones(2,1) * vlengths') ; 
    %  scaled version of data, lying on rmean1 centered circle

paramstruct = struct('npc',2, ...
                     'viout',[0 1], ...
                     'iscreenwrite',1) ;
outstruct = pcaSM(mresrm2s,paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;


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
    plot(rmean1(1,:),rmean1(2,:),'kx','LineWidth',lw2,'MarkerSize',ss2) ;
    plot(rmean1(1,:),rmean1(2,:),'ko','LineWidth',lw2,'MarkerSize',ss2) ;
    plot((rmean1(1,:) + mucircle(1,:)), ...
         (rmean1(2,:) + mucircle(2,:)),'k--') ;
    plot((rmean1(1,:) + mresrm1s(1,:)), ...
         (rmean1(2,:) + mresrm1s(2,:)),'ko') ;
    plot(p1(1,:),p1(2,:),'kx','LineWidth',lw2,'MarkerSize',ss2) ;
    plot(meanp1(1,:),meanp1(2,:),'ko','LineWidth',lw2,'MarkerSize',ss2) ;
    plot((p1(1,:) + mucircle(1,:)), ...
         (p1(2,:) + mucircle(2,:)),'k--') ;
    plot((p1(1,:) + mresp1s(1,:)), ...
         (p1(2,:) + mresp1s(2,:)),'ko') ;
  hold off ;
  axis([left right bottom top]) ;
  axis square ;


subplot(1,2,2) ;    %  Outliers pull off PCA
  plot(mdata2(1,:),mdata2(2,:),'k+','LineWidth',lw1) ;
  hold on ;
    plot((rmean2(1,:) + mucircle(1,:)), ...
         (rmean2(2,:) + mucircle(2,:)),'k--') ;
    plot((rmean2(1,:) + mresrm2s(1,:)), ...
         (rmean2(2,:) + mresrm2s(2,:)),'ko') ;
    plot([rmean2(1,:); (rmean2(1,:) + 2.3 * meigvec(1,1))], ...
         [rmean2(2,:); (rmean2(2,:) + 2.3 * meigvec(1,2))], ...
             'k-','LineWidth',lw3) ;
    plot([rmean2(1,:); (rmean2(1,:) + 1.0 * meigvec(2,1))], ...
         [rmean2(2,:); (rmean2(2,:) + 1.0 * meigvec(2,2))], ...
             'k-','LineWidth',lw3) ;
  hold off ;
  axis([left right bottom top]) ;
  axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig16p3.png') ;



