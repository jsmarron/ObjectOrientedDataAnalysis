disp('Running MATLAB script file OODAfig13p9.m') ;
%
%    Makes Figure 13.9 of the OODA book,
%    SigClust on PanCan Data, Diagnostic Eigenvalues
%
%    Copied from OODAbookChpLFigHSigClustPCkdeQQ.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\PanCancerData' ;

%  Read in data
%
mdata = xlsread(datafilestr) ;

n = size(mdata,2) ;

ns = 50 ;
    %  Number of data points for eacn cancer type
caTypeNames = {'BLCA' 'KIRC' 'OV' 'HNSC' 'COAD' 'BRCA'} ;
    %  Cell Array of these 6 cancer type names

mdatak = mdata(:,(ns + 1):(2 * ns)) ;
    %  Just use second (KIRC) part of data



%  SigClust to split class
%
paramstruct = struct('vclass',0, ...
                     'iCovEst',1, ...
                     'nsim',5, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',1, ...
                     'ipValplot',1, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatak,paramstruct) ;


%  Move green lines off of the plot
%
figure(3) ;
subplot(2,2,1) ;
vachil = get(gca,'Children') ;
set(vachil(5),'XData',[-100 -100]) ;

figure(3) ;
subplot(2,2,2) ;
vachil = get(gca,'Children') ;
set(vachil(5),'XData',[-100 -100]) ;

figure(3) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p9.png') ;



