disp('Running MATLAB script file OODAfig13p12.m') ;
%
%    Makes Figure 13.12 of the OODA book,
%    SigClust on Lung Cancer Data
%
%    Copied from OODAbookChpLFigLScatPlotLungC.m
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


mdatas = [mdata(:,(vclassnum == 1)) mdata(:,(vclassnum == 2)) ...
          mdata(:,(vclassnum == 3))] ;
vclass = [ (2 * ones(1,nc1))  (2 * ones(1,nc2)) ones(1,nc3)] ;
%vcolmix = ([0.6 0.4 0] + [0.8 0 0]) / 2 ;
vcolmix = [0.8 0.5 0] ;
mcolor = [(ones(nc1,1) * vcolmix); (ones(nc2,1) * vcolmix); ...
          (ones(nc3,1) * [0 0 0.7])] ;


figure(1) ;
clf ;

subplot(1,2,1) ;    %  Make graphics as in ipart = 26 ;

  %  Make MD projections
  %
  vMD = mean(mdatas(:,(vclass == 2)),2) - mean(mdatas(:,(vclass == 1)),2) ;
  vMD = vMD / norm(vMD) ;

  %  Make MD & OPC1 graphic
  %
  paramstruct = struct('npc',1, ...
                       'iscreenwrite',1, ...
                       'viout',[0 1]) ;
  mdatasc = mdatas - (vMD * (vMD' * mdatas)) ;
      %  subtract projection onto vMD
  outstruct = pcaSM(mdatasc,paramstruct) ;
  mdir = [vMD getfield(outstruct,'meigvec')] ;
  paramstruct = struct('icolor',mcolor, ...
                       'markerstr','o', ...
                       'xlabelstr','MD scores', ...
                       'ylabelstr','OPC1 scores', ...
                       'savestr',[], ...
                       'iscreenwrite',1) ;
  projplot2SM(mdatas,mdir,paramstruct) ;


subplot(1,2,2) ;    %  Make graphics as in ipart = 26 ;

  %  Make DWD projections
  %
  vDWD = DWD2XQ(mdatas(:,(vclass == 1)),mdatas(:,(vclass == 2))) ;
  vDWD = vDWD / norm(vDWD) ;

  %  Make DWD & OPC1 graphic
  %
  paramstruct = struct('npc',1, ...
                       'iscreenwrite',1, ...
                       'viout',[0 1]) ;
  mdatasc = mdatas - (vDWD * (vDWD' * mdatas)) ;
      %  subtract projection onto vDWD
  outstruct = pcaSM(mdatasc,paramstruct) ;
  mdir = [vDWD getfield(outstruct,'meigvec')] ;
  paramstruct = struct('icolor',mcolor, ...
                       'markerstr','o', ...
                       'xlabelstr','DWD scores', ...
                       'ylabelstr','OPC1 scores', ...
                       'savestr',[], ...
                       'iscreenwrite',1) ;
  projplot2SM(mdatas,mdir,paramstruct) ;



%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig13p12.png') ;




