disp('Running MATLAB script file OODAfig6p8.m') ;
%
%    Makes Figure 6.8 of the OODA book,
%    Illustration of SVD vs. PCA
%
%    Copied from OODAbookChpPFigBSVDvsPCA.m
%    in:        OODAbook\ChapterP
%
%

%  Generate Toy Data
%
n = 25 ;
d = 2 ;
xgrid = [1; 2] ;
mu = [4; 3] ;
%msig = [0.03 0; 0 1.5] ;
msig = [0.15 0; 0 1.5] ;
randn('state',75029743095) ;
mz = randn(d,n) ;
mdata = sqrtm(msig) * mz + vec2matSM(mu,n) ;


%  Do main PCA calculation
%
paramstruct = struct('viout',ones(10,1),...
                     'iscreenwrite',1) ;
outstruct = pcaSM(mdata,paramstruct) ;


%  Unpack useful quantities
%
veigval = getfield(outstruct,'veigval') ;
meigvec = getfield(outstruct,'meigvec') ;
vmean = getfield(outstruct,'vmean') ;
mmeanresid = getfield(outstruct,'mmeanresid') ;
mpc = getfield(outstruct,'mpc') ;
a3proj = getfield(outstruct,'a3proj') ;
sstot = getfield(outstruct,'sstot') ;
ssmresid = getfield(outstruct,'ssmresid') ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
vpropSSpr = getfield(outstruct,'vpropSSpr') ;
mpc(1,:) = -mpc(1,:) ;
meigvec(:,1) = -meigvec(:,1) ; 
    %  Reverse to tackle arbitrary direction


%  Do SVD
%
[mcolev,ms,mrowev] = svd(mdata) ;
      %  [U,S,V] = SVD(X) produces a diagonal matrix S, of the same 
      %  dimension as X and with nonnegative diagonal elements in
      %  decreasing order, and unitary matrices U and V so that
      %  X = U*S*V'.
vs = diag(ms) ;

mcomp1 = mcolev(:,1) * vs(1) * mrowev(:,1)' ;
mcomp2 = mcolev(:,2) * vs(2) * mrowev(:,2)' ;
msvdscores = mrowev(:,1:2) * ms(:,1:2) ;
msvdscores(:,1) = -msvdscores(:,1) ;
    %  Reverse to tackle arbitrary direction


%  Preliminary graphics quantities
%
titfontsize = 18 ;
%labfontsize = 15 ;
labfontsize = 12 ;


mdataw = [mdata(1,:); mdata(1,:); mdata(end,:); mdata(end,:)] ;
    %  Wide version of data, where first and last rows are repeated,
    %       to add "flat parts" at either end
xgridw = [0; xgrid; 3] ;
    %  Corresponding horizontal coordinates
vmeanw = [vmean(1); vmean(1); vmean(end); vmean(end)] ;
mmeanresidw = [mmeanresid(1,:); mmeanresid(1,:); ...
                    mmeanresid(end,:); mmeanresid(end,:)] ; 
mcomp1w = [mcomp1(1,:); mcomp1(1,:); mcomp1(end,:); mcomp1(end,:)] ;
mcomp2w = [mcomp2(1,:); mcomp2(1,:); mcomp2(end,:); mcomp2(end,:)] ;


minx1 = min(min([mdata(1,:), 0])) ;
maxx1 = max(max([mdata(1,:), 0])) ;
rangex1 = maxx1 - minx1 ;
minx1 = minx1 - 0.05 * rangex1 ;
maxx1 = maxx1 + 0.05 * rangex1 ;

minx2 = min(min([mdata(2,:), 0])) ;
maxx2 = max(max([mdata(2,:), 0])) ;
rangex2 = maxx2 - minx2 ;
minx2 = minx2 - 0.05 * rangex2 ;
maxx2 = maxx2 + 0.05 * rangex2 ;

minx = min(minx1,minx2) ;
maxx = max(maxx1,maxx2) ;

bottom = min(minx1,minx2) ;
top = max(maxx1,maxx2) ;


%  Make Graphics
%
figure(1) ;
clf ;


%  Raw Data SV1
%
subplot(2,2,1) ;
  ph1 = plot(mdata(1,:),mdata(2,:),'ko', ...
             [[0; 0], [minx; maxx]], ...
             [[minx; maxx], [0; 0]],'k-', ...
             mcomp1(1,:), mcomp1(2,:),'m+', ...
             [mdata(1,:); mcomp1(1,:)], ...
                 [mdata(2,:); mcomp1(2,:)],'c-', ...
             [-8 * mcolev(1,1); 0.5 * mcolev(1,1)], ...
                 [-8 * mcolev(2,1); 0.5 * mcolev(2,1)],'r-') ;
%    set(ph1(1),'LineWidth',2) ;
    set(ph1(1),'LineWidth',1.5) ;
%    set(ph1(1),'MarkerSize',8) ;
    set(ph1(1),'MarkerSize',4) ;
%    set(ph1(4),'LineWidth',3) ;
    set(ph1(4),'LineWidth',1.5) ;
%    set(ph1(4),'MarkerSize',12) ;
    set(ph1(4),'MarkerSize',7) ;
    for ih = 1:n ;
      set(ph1(4+ih),'LineWidth',1.5) ;
    end ;
%    set(ph1(n+5),'LineWidth',4) ;
    set(ph1(n+5),'LineWidth',2) ;
%    axis([minx1, maxx1, minx2, maxx2]) ;
%    axis square ;
    axis equal ;
    axis([minx, maxx, minx, maxx]) ;
%    title(['Raw ' datatitstr],'FontSize',titfontsize) ;
    xlabel('x_1','FontSize',labfontsize) ;
    ylabel('x_2','FontSize',labfontsize) ;
      tx = minx1 + 0.1 * (maxx - minx) ;
      ty = minx2 + 0.9 * (maxx - minx) ;
      text(tx,ty,'Feature Space View',  ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.8 * (maxx - minx) ;
      text(tx,ty,'SV Direction 1',  ...
                'Color','r', ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.7 * (maxx - minx) ;
      text(tx,ty,'SV1 Projections',  ...
                'Color','m', ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.6 * (maxx - minx) ;
      text(tx,ty,'SV1 Residuals',  ...
                'Color','c', ...
                'FontSize',labfontsize) ;


%  Raw Data PC1
%
subplot(2,2,2) ;
  ph1 = plot(mdata(1,:),mdata(2,:),'ko', ...
             [[0; 0], [minx; maxx]], ...
             [[minx; maxx], [0; 0]],'k-', ...
             meigvec(1,1) * mpc(1,:) + vmean(1), ...
                 meigvec(2,1) * mpc(1,:) + vmean(2),'m+', ...
             [mdata(1,:); meigvec(1,1) * mpc(1,:) + vmean(1)], ...
                 [mdata(2,:); meigvec(2,1) * mpc(1,:) + vmean(2)],'c-', ...
             [-5 * meigvec(1,1) + vmean(1); 5 * meigvec(1,1) + vmean(1)], ...
                 [-5 * meigvec(2,1) + vmean(2); 5 * meigvec(2,1) + vmean(2)],'r-', ...
             vmean(1),vmean(2),'g+') ;
%    set(ph1(1),'LineWidth',2) ;
    set(ph1(1),'LineWidth',1.5) ;
%    set(ph1(1),'MarkerSize',8) ;
    set(ph1(1),'MarkerSize',4) ;
%    set(ph1(4),'LineWidth',3) ;
    set(ph1(4),'LineWidth',1.5) ;
%    set(ph1(4),'MarkerSize',12) ;
    set(ph1(4),'MarkerSize',7) ;
    for ih = 1:n ;
      set(ph1(4+ih),'LineWidth',1.5) ;
    end ;
%    set(ph1(n+5),'LineWidth',4) ;
    set(ph1(n+5),'LineWidth',2) ;
%    set(ph1(n+6),'LineWidth',3) ;
%    set(ph1(n+6),'MarkerSize',12) ;
    set(ph1(n+6),'LineWidth',3) ;
    set(ph1(n+6),'MarkerSize',10) ;
    set(ph1(n+6),'Color',[0 0.7 0]) ;
%    axis([minx1, maxx1, minx2, maxx2]) ;
%    axis square ;
    axis equal ;
    axis([minx, maxx, minx, maxx]) ;
%    title(['Raw ' datatitstr],'FontSize',titfontsize) ;
    xlabel('x_1','FontSize',labfontsize) ;
    ylabel('x_2','FontSize',labfontsize) ;
      tx = minx1 + 0.1 * (maxx - minx) ;
      ty = minx2 + 0.9 * (maxx - minx) ;
      text(tx,ty,'Feature Space View',  ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.8 * (maxx - minx) ;
      text(tx,ty,'PC Direction 1',  ...
                'Color','r', ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.7 * (maxx - minx) ;
      text(tx,ty,'PC1 Projections',  ...
                'Color','m', ...
                'FontSize',labfontsize) ;
      ty = minx2 + 0.6 * (maxx - minx) ;
      text(tx,ty,'PC1 Residuals',  ...
                'Color','c', ...
                'FontSize',labfontsize) ;


%  Scatterplot SV1 scores
%
subplot(2,2,3) ;
left = -0.3 ;
vaxsvdx = axisSM(msvdscores(:,1)) ;
vaxsvdy = axisSM(msvdscores(:,2)) ;
ph3 = plot(msvdscores(:,1),msvdscores(:,2),'ko', ...
             [left; vaxsvdx(2)],[0; 0],'k-', ...
             [0;0],[vaxsvdy(1); vaxsvdy(2)],'k-') ;
    set(ph3(1),'LineWidth',1.5) ;
    set(ph3(1),'MarkerSize',4) ;
  axis equal ;
  axis([left vaxsvdx(2) vaxsvdy(1) vaxsvdy(2)]) ;
  xlabel('SV1 Scores','FontSize',labfontsize,'Color','m') ;
  ylabel('SV2 SCores','FontSize',labfontsize,'Color','c') ;
    tx = 0 + 0.1 * (vaxsvdx(2) - 0) ;
    ty = vaxsvdy(1) + 0.9 * (vaxsvdy(2) - vaxsvdy(1)) ;
    text(tx,ty,['Corr = ' num2str(corr(msvdscores(:,1),msvdscores(:,2)),3)],  ...
              'FontSize',labfontsize) ;


%  Scatterplot PC1 scores
%
subplot(2,2,4) ;
axmax = 1.05 * max(max(mpc)) ;
ph4 = plot(mpc(1,:),mpc(2,:),'ko', ...
             [-axmax; axmax],[0; 0],'k-', ...
             [0; 0],[-axmax; axmax],'k-') ;
    set(ph4(1),'LineWidth',1.5) ;
    set(ph4(1),'MarkerSize',4) ;
  axis equal ;
  axis([-axmax axmax -axmax axmax]) ;
  xlabel('PC1 Scores','FontSize',labfontsize,'Color','m') ;
  ylabel('PC2 SCores','FontSize',labfontsize,'Color','c') ;
    tx = -axmax + 0.1 * (2 * axmax) ;
    ty = -axmax + 0.9 * (2 * axmax) ;
    text(tx,ty,['Corr = ' num2str(-corr(mpc(1,:)',mpc(2,:)'),'%5.3f')],  ...
              'FontSize',labfontsize) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig6p8.png') ;



