disp('Running MATLAB script file OODAfig13p10.m') ;
%
%    Makes Figure 13.10 of the OODA book,
%    SigClust on PanCan Data, p-value plots
%
%    Copied from OODAbookChpLFigJSigClustPCpvals.m
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
                     'nsim',1000, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',1, ...
                     'ipValplot',1, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatak,paramstruct) ;

figure(4) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p10A.png') ;


%  SigClust with Sample Covariance Estimate
%
paramstruct = struct('vclass',0, ...
                     'iCovEst',2, ...
                     'nsim',1000, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',1, ...
                     'ipValplot',1, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatak,paramstruct) ;

figure(2) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p10B.png') ;







