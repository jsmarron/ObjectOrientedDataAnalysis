disp('Running MATLAB script file OODAfig16p4.m') ;
%
%    Makes Figure 16.4 of the OODA book,
%    Parabolas and Outlier Data, Spherical PCA curvdat
%
%    Copied from OODAbookChpOFigD10dToynOutSPCA.m
%    in:        OODAbook\ChapterO
%

ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\ParabolasAndOutlierData' ;
datastr = 'Parabolas' ;
n = 50 ;
d = 10 ;


%  Read in data
%
mdata = xlsread(datafilestr) ;


%  Generate graphics
%
mcolor = ones(n,1) * [0 0 0] ;
mcolor = [mcolor; [1 0 0]] ;


%  Top part first
%
figure(1) ;
clf ;

paramstruct = struct('itype',4, ...
                     'viout',1, ...
                     'vipcplot',[0], ...
                     'vicolplot',[1 2 4], ...
                     'icolor',mcolor, ...
                     'dolhtseed',37402983, ...
                     'legendcellstr',{{datastr}}, ...
                     'iaxlim',0, ...
                     'iscreenwrite',1) ;
curvdatSM(mdata,paramstruct) ;
subplot(1,3,2) ;
title('Mean') ;
%  Turn off text in 2nd panel
vah = get(gcf,'Children') ;
vah2c = get(vah(2),'Children') ;
set(vah2c(1),'String','') ;
subplot(1,3,3) ;
%title('Mean Residuals') ;
title('Scree Plot') ;
%  Turn off text in 3rd panel
vah = get(gcf,'Children') ;
vah1c = get(vah(1),'Children') ;
set(vah1c(1),'String','') ;
set(vah1c(2),'LineWidth',1.5) ;    %  Upper scree curve
set(vah1c(2),'Color',[0 0 1]) ;    %  Upper scree curve
set(vah1c(3),'LineWidth',1.5) ;    %  Upper scree curve
set(vah1c(3),'Color',[1 0 0]) ;    %  Upper scree curve

%  Add symbols showing scree based on original sums of squares
%
%  Use lines from curvdatSM
%
  vcenter = rmeanSM(mdata',(10^-6),20,0)' ;
          %  Huber's L1 M-estimate
          %  accuracy parameters, and 0 for no screen writes
  mresid = mdata - vec2matSM(vcenter,n + 1) ;
  sscr = sum(sum(mresid .^ 2)) ;

  vrad = sqrt(sum(mresid .^2)) ;
          %  Transpose, since want "coordinates as variables"
          %  vector of radii of each curve
  sphereresid = mresid' ./ vec2matSM(vrad',d) ;
          %  make each curve have "length" one

  tmresid = sphereresid' ;
      %  transformed version of residuals
  sstmr = sum(sum(tmresid .^ 2)) ;

paramstruct = struct('npc',10, ...
                     'iprestd',1, ...
                     'viout',[1 1 0 0 0 0 0 0 1 0], ...
                     'iscreenwrite',0) ;
outstruct = pcaSM(tmresid / sqrt(n - 1),paramstruct) ;
veigval = getfield(outstruct,'veigval') ;
    %  vector eigenvalues
tmeigvec = getfield(outstruct,'meigvec') ;
    %  matrix of eigenvectors of transformed data
    %  Note: these are sorted so largest eigenvalues are first
    %        and eigen vectors are column vectors
tvpropSScr = getfield(outstruct,'vpropSSmr') ;
    %  vector of Proportions of Mean Residuals
    %  of transformed data
    %  for plotting lines in power plot

rss1 = sum((tmeigvec(:,1)' * mresid).^2) / sscr ;
rss2 = sum((tmeigvec(:,2)' * mresid).^2) / sscr ;
rss3 = sum((tmeigvec(:,3)' * mresid).^2) / sscr ;

hold on ;
  lw = 2 ;
  plot(1,rss1,'ro','LineWidth',lw) ;
  plot(2,rss2,'ro','LineWidth',lw) ;
  plot(3,rss3,'ro','LineWidth',lw) ;
  plot(1,rss1,'b+','LineWidth',lw) ;
  plot(2,rss1 + rss2,'b+','LineWidth',lw) ;
  plot(3,rss1 + rss2 + rss3,'b+','LineWidth',lw) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 
print('-dpng','OODAfig16p4A.png') ;


%  Then lower part
%
figure(2) ;
clf ;

paramstruct = struct('itype',4, ...
                     'viout',1, ...
                     'vipcplot',[1 2 3], ...
                     'vicolplot',[1 3 4], ...
                     'icolor',mcolor, ...
                     'dolhtseed',37402983, ...
                     'legendcellstr',{{datastr}}, ...
                     'iaxlim',0, ...
                     'iscreenwrite',1) ;
curvdatSM(mdata,paramstruct) ;
%  Turn off text in 2nd panel
vah = get(gcf,'Children') ;
vah2c = get(vah(2),'Children') ;
set(vah2c(1),'String','') ;
%  Turn off text in 5th panel
vah = get(gcf,'Children') ;
vah5c = get(vah(5),'Children') ;
set(vah5c(1),'String','') ;
%  Turn off text in 8th panel
vah = get(gcf,'Children') ;
vah8c = get(vah(8),'Children') ;
set(vah8c(1),'String','') ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig16p4B.png') ;



