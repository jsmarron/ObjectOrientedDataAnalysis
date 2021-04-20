disp('Running MATLAB script file OODAfig3p5.m') ;
%
%    Makes Figure 3.5 of the OODA book,
%    Scree plot for:
%                       2-d toy data
%                       Spanish Male Mortality data
%                       10-d toy data
%
%    Copied from OODAbookChpBFigYScree.m
%    in:        OODAbook\ChapterB
%


%  Generate Graphics
%
figure(1) ;
clf ;
ms = 8 ;
lw = 2 ;


%  Make scree plot for 2-d toy data
%
subplot(2,2,1) ;

%  Generate data using lines from OODAbookChpBFigD.m
% 
d = 2 ;
xgrid = [1; 2] ;
n = 12 ;

mu = [3.3; 0.6] ;
msig = [0.08 0; 0 0.08] ;
randn('state',75029743095) ;
mz = randn(d,n) ;
mdata1 = sqrtm(msig) * mz + vec2matSM(mu,n) ;

mu = [2.5; 3.8] ;
msig = [0.05 0; 0 0.05] ;
mz = randn(d,n) ;
mdata1 = [mdata1 (sqrtm(msig) * mz + vec2matSM(mu,n))] ;

%  Do PCA
%
npc1 = 2 ;
    %  number of PCs to compute
paramstruct = struct('npc',npc1, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 0 0 0 0 1]) ;
outstruct = pcaSM(mdata1,paramstruct) ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
vcum = cumsum(vpropSSmr) ;
vcum = [vcum; 1] ;

%  make plot
plot((1:npc1)',vpropSSmr,'r-','Linewidth',lw) ;
hold on ;
  plot((1:(npc1 + 1))',vcum,'b--','Linewidth',lw) ;
  plot(1,vpropSSmr(1),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vpropSSmr(2),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(1,vcum(1),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vcum(2),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot([0; (npc1 + 1)],[0; 0],'k:') ;
  plot([0; (npc1 + 1)],[1; 1],'k:') ;
hold off ;
axis([0.5 (npc1 + 0.5) -0.05 1.05]) ;
%xlabel('component index') ;
xlabel('mode index') ;
ylabel('Proportion of Variation') ; 
set(gca,'XTick',[1 2]) ;
disp(['    Upper left plot had 1st propn = ' num2str(vpropSSmr(1))]) ;


%  Make scree plot for mortality data
%
subplot(2,2,2) ;

%  Load data from Excel file
%
mdata = xlsread('..\..\DataSets\SpanishMaleMortalityData.xlsx','Sheet1','B2:CR112') ;
    %    Rows of mdata are ages 0 - 110
    %    Columns are years 1908 - 2002

%  Cut off ages after 98
%
mdata2 = log10(mdata(1:99,:)) ;
    %  take first 99 rows
    %  put on log 10 scale

%  Do PCA
%
npc2 = 7 ;
    %  number of PCs to compute
paramstruct = struct('npc',npc2, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 0 0 0 0 1]) ;
outstruct = pcaSM(mdata2,paramstruct) ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
vcum = cumsum(vpropSSmr) ;

%  make plot
plot((1:npc2)',vpropSSmr,'r-','Linewidth',lw) ;
hold on ;
  plot((1:npc2)',vcum,'b--','Linewidth',lw) ;
  plot(1,vpropSSmr(1),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vpropSSmr(2),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(1,vcum(1),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vcum(2),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot([0; (npc2 + 1)],[0; 0],'k:') ;
  plot([0; (npc2 + 1)],[1; 1],'k:') ;
hold off ;
axis([0.5 (npc2 - 0.5) -0.05 1.05]) ;
%xlabel('component index') ;
xlabel('mode index') ;
disp(['    Upper right plot had 1st propn = ' num2str(vpropSSmr(1))]) ;



%  Make scree plot for 10-d toy data
%
subplot(2,2,3) ;

%  Generate data using lines from OODAbookChpBFigG.m
% 
d = 10 ;
n = 50 ;
xgrid = (.5:1:d)' ;
mdata3 = (xgrid - 6).^2 ;
  randn('seed',88769874) ;
  eps1 = 4 * randn(1,n) ;
  eps2 = .5 * randn(1,n) ;
  eps3 = 1 * randn(d,n) ;
mdata3 = vec2matSM(mdata3,n) + vec2matSM(eps1,d) + ...
               vec2matSM(eps2,d) .* vec2matSM(xgrid-d/2,n) + eps3 ;

%  Do PCA
%
npc3 = 9 ;
    %  number of PCs to compute
paramstruct = struct('npc',npc3, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 0 0 0 0 1]) ;
outstruct = pcaSM(mdata3,paramstruct) ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
vcum = cumsum(vpropSSmr) ;

%  make plot
plot((1:npc3)',vpropSSmr,'r-','Linewidth',lw) ;
hold on ;
  plot((1:npc3)',vcum,'b--','Linewidth',lw) ;
  plot(1,vpropSSmr(1),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vpropSSmr(2),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(3,vpropSSmr(3),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(4,vpropSSmr(4),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(1,vcum(1),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vcum(2),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(3,vcum(3),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(4,vcum(4),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot([0; (npc3 + 1)],[0; 0],'k:') ;
  plot([0; (npc3 + 1)],[1; 1],'k:') ;
hold off ;
axis([0.5 (npc3 - 0.5) -0.05 1.05]) ;
%xlabel('component index') ;
xlabel('mode index') ;
ylabel('Proportion of Variation') ; 
disp(['    Lower left plot had 1st propn = ' num2str(vpropSSmr(1))]) ;



%  Make scree plot for PanCan data
%
subplot(2,2,4) ;

%  Load data using lines from OODAbookChpBFigX.m
%
mdata4 = xlsread('OODAbookChpBFigQdata.xlsx','Sheet1','B3:KO12480') ;

%  Do PCA
%
npc4 = 20 ;
    %  number of PCs to compute
paramstruct = struct('npc',npc4, ...
                     'iscreenwrite',1, ...
                     'viout',[0 0 0 0 0 0 0 0 1]) ;
outstruct = pcaSM(mdata4,paramstruct) ;
vpropSSmr = getfield(outstruct,'vpropSSmr') ;
vcum = cumsum(vpropSSmr) ;

%  make plot
plot((1:npc4)',vpropSSmr,'r-','Linewidth',lw) ;
hold on ;
  plot((1:npc4)',vcum,'b--','Linewidth',lw) ;
  plot(1,vpropSSmr(1),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vpropSSmr(2),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(3,vpropSSmr(3),'ro','Linewidth',lw,'MarkerSize',ms) ;
  plot(1,vcum(1),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(2,vcum(2),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot(3,vcum(3),'b+','Linewidth',lw,'MarkerSize',ms) ;
  plot([0; (npc4 + 1)],[0; 0],'k:') ;
  plot([0; (npc4 + 1)],[1; 1],'k:') ;
hold off ;
axis([0.5 (npc4 - 0.5) -0.05 1.05]) ;
%xlabel('component index') ;
xlabel('mode index') ;
disp(['    Lower right plot had 1st propn = ' num2str(vpropSSmr(1))]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 11.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 10.5]) ; 
print('-dpng','OODAfig3p5.png') ;


