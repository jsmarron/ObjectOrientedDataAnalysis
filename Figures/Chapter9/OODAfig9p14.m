disp('Running MATLAB script file OODAfig9p14.m') ;
%
%    Makes Figure 9.14 of the OODA book,
%    Shifted Betas - PNS approximation
%
%    Copied from OODAbookChpHFigMToyWarpPNS.m
%    in:        OODAbook\ChapterH
%


datafilestr = '..\..\DataSets\ShiftedBetasData' ;

d = 1001 ;
      %  dimension of each data curve
xgrid = linspace(0,1,d)' ;
n = 29 ;
      %  number of data curves
mxgrid = xgrid * ones(1,n) ;


%  Read in data
%
mfi = xlsread(datafilestr) ;



%  Run Fisher Rao Decomposition
%
[fn,qn,q0,fmean,mqn,gam] = time_warping(mfi,xgrid) ;


%  Do standard PCA on warp functions, gam
%
paramstruct = struct('npc',2, ...
                     'iscreenwrite',1, ...
                     'viout',[0 1 1 0 1]) ;
outstruct = pcaSM(gam,paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;
vmean = getfield(outstruct,'vmean') ;
mpc = getfield(outstruct,'mpc') ;


%  Get 1st PNS repressentation of data
%  using lines from Xiaosun's curvepnsLXS
npns = 1 ;
    %  only need first component

%%  do main PNS
psi = fun2srvf(gam,xgrid);
    %  changed input t to xgrid
radius = mean(sqrt(sum(psi.^2)));
pnsdat = psi./repmat(sqrt(sum(psi.^2)),d-1,1)*1;

[resmat PNS]=PNSmainHDLSS(pnsdat,1);
    %  changed input pnsType to 1

scores = resmat((1:npns),:)*radius;

%%%%%%%%%%%%%%%%%%%%%%%
EuclidData = resmat;
% vector of st.dev
stdevPNS = sqrt(sum(abs(EuclidData).^2, 2) / n);
% matrix of direction vectors
udir = eye(size(EuclidData,1));

projPsi = zeros(d-1,n,npns);
for PCnum = 1:npns;
    ptEval =  udir(:,PCnum)*resmat(PCnum,:) ;
    % evaluation points on pre-shape space
    PCvec= PNSe2s(ptEval,PNS);
    projPsi(:,:,PCnum) = PCvec*radius;
end;

% Psi->gam
projGam = zeros(d,n,npns);
for i = 1:npns;
    projGam(:,:,i) = srvf2fun(projPsi(:,:,i),xgrid,0);
        %  changed input t to xgrid
end;
% save for output
warps = projGam;


%  Project gammas onto PCA eigenvectors
%
gampns1 = squeeze(warps) ;
    %  n x d version
gampnscent = gampns1 - vmean * ones(1,n) ;
    %  mean centered version
mpnsscores = meigvec' * gampnscent ;
    %  scores in Eucllidean PC12 space


%  Make main graphic
%
figure(7) ;
clf ;
colmap = RainbowColorsQY(n) ;
lw1 = 1.0 ;
lw2 = 1.5 ;
lw3 = 1.5 ;
ms1 = 6 ;
ms2 = 7 ;
ms3 = 7 ;

plot(mpc(1,1),mpc(2,1),'o','Color',colmap(1,:), ...
                'LineWidth',lw1,'MarkerSize',ms1) ;
    %  data projected onto this 2-d space
hold on ;
  plot(mpc(1,1),0,'x','Color',colmap(1,:), ...
                  'LineWidth',lw2,'MarkerSize',ms2) ;
      %  1-d Euclidean PC representation of data
  plot(mpnsscores(1,1),mpnsscores(2,1),'+','Color',colmap(1,:), ...
                  'LineWidth',lw3,'MarkerSize',ms3) ;
      %  1st PNS representation projected onto this 2-d space
  for idat = 2:n ;
    plot(mpc(1,idat),mpc(2,idat),'o','Color',colmap(idat,:), ...
                    'LineWidth',lw1,'MarkerSize',ms1) ;
    plot(mpc(1,idat),0,'x','Color',colmap(idat,:), ...
                    'LineWidth',lw2,'MarkerSize',ms2) ;
    plot(mpnsscores(1,idat),mpnsscores(2,idat),'+','Color',colmap(idat,:), ...
                    'LineWidth',lw3,'MarkerSize',ms3) ;
  end ;
hold off ;
axisSM([mpc(1,:) mpnsscores(1,:)],[mpc(2,:) mpnsscores(2,:)]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 7.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
print('-dpng','OODAfig9p14.png') ;



