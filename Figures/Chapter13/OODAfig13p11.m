disp('Running MATLAB script file OODAfig13p11.m') ;
%
%    Makes Figure 13.11 of the OODA book,
%    SigClust on Lung Cancer Data
%
%    Copied from OODAbookChpLFigKSigClustLungC.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\LungCancerData' ;

%  Read in data
%
mdata = xlsread(datafilestr) ;

n = size(mdata,2) ;


%  First find cluster labels
%
paramstruct = struct('npc',4,...      
                     'iscreenwrite',1,...                       
                     'viout',[0 0 0 0 1]) ;  
outstruct = pcaSM(mdata,paramstruct) ;  
mpc = getfield(outstruct,'mpc') ;

vclassnum = ones(n,1) ;
vflag = (mpc(1,:) > 0)' ;
vclassnum(vflag) = 2 * ones(sum(vflag),1) ;
vflag = (mpc(2,:) > 4)' ;
vclassnum(vflag) = 3 * ones(sum(vflag),1) ;

nc1 = sum(vclassnum == 1) ;
nc2 = sum(vclassnum == 2) ;
nc3 = sum(vclassnum == 3) ;

mdatas = [mdata(:,(vclassnum == 2)) mdata(:,(vclassnum == 3))] ;


%  Default SigClust to see KDE
%
figure(1) ;
clf ;
paramstruct = struct('vclass',0, ...
                     'iCovEst',1, ...
                     'nsim',5, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',1, ...
                     'ipValplot',1, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatas,paramstruct) ;

figure(1) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p11A.png') ;



%  Sample Covariance SigCLust
%
figure(1) ;
clf ;
paramstruct = struct('vclass',0, ...
                     'iCovEst',2, ...
                     'nsim',1000, ...
                     'iBGSDdiagplot',1, ...
                     'iCovEdiagplot',1, ...
                     'ipValplot',1, ...
                     'iscreenwrite',2) ;
[pval, zscore] = SigClustSM(mdatas,paramstruct) ;

figure(2) ;
%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig13p11B.png') ;



