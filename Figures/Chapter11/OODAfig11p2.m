disp('Running MATLAB script file OODAfig11p2.m') ;
%
%    Makes Figure 11.2 of the OODA book,
%    Shifted Correlated Gaussians Data
%    Nonparametric Derivation of LDA
%
%    Copied from OODAbookChpJFigBFLDIntro.m
%    in:        OODAbook\ChapterJ
%

datafilestr = '..\..\DataSets\ShiftedCorrelatedGaussiansData' ;

n = 100 ;


%  Read in data
%
data1 = xlsread(datafilestr,'data1') ;
data2 = xlsread(datafilestr,'data2') ;


%  Make main graphic
%
figure(1) ;
clf ;



%  Compute Direction Vectors
%
vmean1 = mean(data1',2) ;
vmean2 = mean(data2',2) ;
mdata = [data1' data2'] ;
vmean = mean([vmean1 vmean2],2) ;

mresid1 = data1' - vec2matSM(vmean1,n) ;
mresid2 = data2' - vec2matSM(vmean2,n) ;
mresid = [mresid1 mresid2] ;

mcov = cov(mresid') ;
          %  Get covariance matrix, transpose, since want 
          %               "coordinates as variables"
mcovinv = pinv(mcov) ;
          %  pseudo-inverse
vdir = mcovinv * (vmean1 - vmean2) ;
          %  Direction Vector
vdir = vdir / norm(vdir) ;
          %  make it a unit vector
dirov = [-vdir(2); vdir(1)] ;
mdirvec = [(vmean + 2 * vdir), (vmean - 10 * dirov), (vmean + 10 * dirov)] ;


%  Construct sphered versions
%
rootmcovinv = sqrtm(mcovinv) ;
sphdata1 = (rootmcovinv * data1')' ;
sphdata2 = (rootmcovinv * data2')' ;

sphvmean = rootmcovinv * vmean ;
sphvmean1 = rootmcovinv * vmean1 ;
sphvmean2 = rootmcovinv * vmean2 ;
sphmdirvec = sphvmean1 - sphvmean2 ;
          %  find vector that connects means
sphmdirvec = sphmdirvec / norm(sphmdirvec) ;
          %  make it a unit vector
sphdirov = [-sphmdirvec(2); sphmdirvec(1)] ;
rawsphmdirvec = sphmdirvec ;
          % keep for comparison
sphmdirvec = [(sphvmean + 3 * sphmdirvec), ...
              (sphvmean - 10 * sphdirov), ...
              (sphvmean + 10 * sphdirov)] ;
          %  adjust for plotting


%  Do a numerical check
%
tdirv = rootmcovinv * rawsphmdirvec ;
tdirv = tdirv / norm(tdirv) ;
aerror = max(abs(vdir - tdirv)) ;
disp(['    Check this is 0: ' num2str(aerror)]) ;


subplot(2,2,1) ;
  plot(data1(:,1),data1(:,2),'r.', ...
       data2(:,1),data2(:,2),'b.', ...
       [[0;0], [-4;4]],[[-4;4], [0;0]],'k-', ...
              'MarkerSize',10) ;
  axis equal ;
  axis([-4,4,-4,4]) ;
  axis off ;


subplot(2,2,2) ;
  plot(sphdata1(:,1),sphdata1(:,2),'r.', ...
       sphdata2(:,1),sphdata2(:,2),'b.', ...
       [[0;0], [-6;6]],[[-6;6], [0;0]],'k-', ...
              'MarkerSize',10) ;
  axis equal ;
  axis([-6,6,-6,6]) ;
  axis off ;


subplot(2,2,3) ;
  plot(data1(:,1),data1(:,2),'r.', ...
       data2(:,1),data2(:,2),'b.', ...
       [[0;0], [-4;4]],[[-4;4], [0;0]],'k-', ...
              'MarkerSize',10) ;
  hold on ;
    plot([vmean(1) ; mdirvec(1,1)], ...
         [vmean(2) ; mdirvec(2,1)], ...
             'm-','LineWidth',3) ;
    plot([mdirvec(1,3) ; mdirvec(1,2)],[mdirvec(2,3); mdirvec(2,2)], ...
             'm--','LineWidth',2) ;
    plot([vmean(1) vmean1(1) vmean2(1)], ...
         [vmean(2) vmean1(2) vmean2(2)], 'mo', ...
          'LineWidth',2,'MarkerSize',12) ;
    plot([vmean1(1) vmean2(1)], ...
         [vmean1(2) vmean2(2)], 'mx', ...
          'LineWidth',2,'MarkerSize',12) ;
    plot(vmean(1),vmean(2), 'm+', ...
          'LineWidth',2,'MarkerSize',12) ;
  hold off ;
  axis equal ;
  axis([-4,4,-4,4]) ;
  axis off ;


subplot(2,2,4) ;
  plot(sphdata1(:,1),sphdata1(:,2),'r.', ...
       sphdata2(:,1),sphdata2(:,2),'b.', ...
       [[0;0], [-6;6]],[[-6;6], [0;0]],'k-', ...
              'MarkerSize',10) ;
  hold on ;
    plot([sphvmean(1) ; sphmdirvec(1)], ...
         [sphvmean(2) ; sphmdirvec(2)], ...
             'm-','LineWidth',3) ;
    plot([sphmdirvec(1,3) ; sphmdirvec(1,2)],[sphmdirvec(2,3); sphmdirvec(2,2)], ...
             'm--','LineWidth',2) ;
    plot([sphvmean(1) sphvmean1(1) sphvmean2(1)], ...
         [sphvmean(2) sphvmean1(2) sphvmean2(2)], 'mo', ...
          'LineWidth',2,'MarkerSize',12) ;
    plot([sphvmean1(1) sphvmean2(1)], ...
         [sphvmean1(2) sphvmean2(2)], 'mx', ...
          'LineWidth',2,'MarkerSize',12) ;
    plot(sphvmean(1),sphvmean(2), 'm+', ...
          'LineWidth',2,'MarkerSize',12) ;

  hold off ;
  axis equal ;
  axis([-6,6,-6,6]) ;
  axis off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig11p2.png') ;



