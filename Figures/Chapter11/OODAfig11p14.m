disp('Running MATLAB script file OODAfig11p14.m') ;
%
%    Makes Figure 11.14 of the OODA book,
%    Toy Example Bathc Adjustment
%
%    Copied from OODAbookChpJFigJBatchAdjDWD.m
%    in:        OODAbook\ChapterJ
%

ncfull = 160 ;
    %  number in each full data cluster
rng(87463986) ;
cent = 4 ;
bignum = 20 ;
mdcolor = [0 0.7 0] ;
dwdcolor = [1 0.3 1] ;

mdata1full = [([cent; cent] * ones(1,ncfull) + randn(2,ncfull)) ... 
              ([-cent; cent] * ones(1,ncfull) + randn(2,ncfull))] ;
mdata2full = [([-cent; -cent] * ones(1,ncfull) + randn(2,ncfull)) ... 
              ([cent; -cent] * ones(1,ncfull) + randn(2,ncfull))] ;

vax1 = axisSM([mdata1full(1,:) mdata2full(1,:)], ...
              [mdata1full(2,:) mdata2full(2,:)]) ;

ns = 40 ;

figure(1) ;
clf ;

mdata1 = mdata1full(:,1:(ncfull + ns)) ;
mdata2 = mdata2full(:,1:(ncfull + ns)) ;

vmean1 = mean(mdata1,2) ;
vmean2 = mean(mdata2,2) ;
vMDdir = (vmean1 - vmean2) ;
vMDdir = vMDdir / norm(vMDdir) ;
vMDperp = [vMDdir(2); -vMDdir(1)] ;
    %  orthogonal unit vector in 2-d
vMDcent = (vmean1 + vmean2) / 2 ;
mMDdata1 = mdata1 - vmean1 * ones(1,ncfull + ns) ;
mMDdata2 = mdata2 - vmean2 * ones(1,ncfull + ns) ;
vax3 = axisSM([mMDdata1(1,:) mMDdata2(1,:)], ...
              [mMDdata1(2,:) mMDdata2(2,:)]) ;

[vDWDdir beta] = DWD2XQ(mdata1,mdata2) ;
vDWDperp = [vDWDdir(2); -vDWDdir(1)] ;
vDWDcent = vDWDdir * beta ;

paramstruct = struct('viplot',zeros(4,1)) ;
DWDadjdata = BatchAdjustCC([mdata1 mdata2], ...
                           [ones(1,(ncfull + ns)) -ones(1,(ncfull + ns))], ...  
                           paramstruct) ;
mDWDdata1 = DWDadjdata(:,1:(ncfull + ns)) ;
mDWDdata2 = DWDadjdata(:,(ncfull + ns + 1):end) ;
vax2 = axisSM(DWDadjdata(1,:),DWDadjdata(2,:)) ;

subplot(1,2,1) ;
hold on ;
  plot(mdata1(1,1:ncfull),mdata1(2,1:ncfull),'b+') ;
  plot(mdata1(1,(ncfull + 1):end),mdata1(2,(ncfull + 1):end),'r+') ;
  plot(mdata2(1,1:ncfull),mdata2(2,1:ncfull),'ro') ;
  plot(mdata2(1,(ncfull + 1):end),mdata2(2,(ncfull + 1):end),'bo') ;
  plot([vDWDcent(1) + bignum * vDWDdir(1) ; vDWDcent(1) - bignum * vDWDdir(1)], ...
       [vDWDcent(2) + bignum * vDWDdir(2); vDWDcent(2) - bignum * vDWDdir(2)], ...
                      '--','Color',dwdcolor,'LineWidth',4) ;
  plot([vDWDcent(1) + bignum * vDWDperp(1) ; vDWDcent(1) - bignum * vDWDperp(1)], ...
       [vDWDcent(2) + bignum * vDWDperp(2); vDWDcent(2) - bignum * vDWDperp(2)], ...
                      '-','Color',dwdcolor,'LineWidth',2) ;
  plot(vmean1(1),vmean1(2),'x','Color',mdcolor, ...
                      'MarkerSize',16,'LineWidth',4) ;
  plot(vmean2(1),vmean2(2),'x','Color',mdcolor, ...
                      'MarkerSize',16,'LineWidth',4) ;
  plot([vmean1(1); vmean2(1)], ...
       [vmean1(2); vmean2(2)],'--','Color',mdcolor, ...
                      'LineWidth',4) ;
  axis(vax1) ;
  axis equal ;
  axis manual ;
hold off ;

subplot(2,2,2) ;
  hold on ;
    plot(mDWDdata1(1,1:ncfull),mDWDdata1(2,1:ncfull),'b+') ;
    plot(mDWDdata1(1,(ncfull + 1):end),mDWDdata1(2,(ncfull + 1):end),'r+') ;
    plot(mDWDdata2(1,1:ncfull),mDWDdata2(2,1:ncfull),'ro') ;
    plot(mDWDdata2(1,(ncfull + 1):end),mDWDdata2(2,(ncfull + 1):end),'bo') ;
  hold off ;
%  axis([-8 8.4 -4 4.3]) ;
  axis([-10 10 -4.5 4.5]) ;
  axis equal ;
  axis manual ;
  title('DWD Adjusted Data','FontSize',12,'Color',dwdcolor) ;

subplot(2,2,4) ;
  hold on ;
    plot(mMDdata1(1,1:ncfull),mMDdata1(2,1:ncfull),'b+') ;
    plot(mMDdata1(1,(ncfull + 1):end),mMDdata1(2,(ncfull + 1):end),'r+') ;
    plot(mMDdata2(1,1:ncfull),mMDdata2(2,1:ncfull),'ro') ;
    plot(mMDdata2(1,(ncfull + 1):end),mMDdata2(2,(ncfull + 1):end),'bo') ;
  hold off ;
%  axis([-10 10.2 -3 3.5]) ;
  axis([-10 10 -4.5 4.5]) ;
  axis equal ;
  axis manual ;
  title('MD Adjusted Data','FontSize',12,'Color',mdcolor) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 6.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 5.5]) ; 
print('-dpng','OODAfig11p14.png') ;



