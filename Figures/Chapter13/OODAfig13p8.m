disp('Running MATLAB script file OODAfig13p8.m') ;
%
%    Makes Figure 13.8 of the OODA book,
%    SigClust on PanCan Data, Diagnostic KDE & QQ plot
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
figure(1) ;
clf ;
paramstruct = struct('vclass',0, ...
                     'iCovEst',1, ...
                     'nsim',5, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',0, ...
                     'ipValplot',0, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatak,paramstruct) ;


figure(1) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p8A.png') ;


figure(2) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p8B.png') ;



