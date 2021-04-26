disp('Running MATLAB script file OODAfig13p3.m') ;
%
%    Makes Figure 13.3 of the OODA book,
%    DiProPerm of Pan Cancer data 2
%
%    Copied from OODAbookChpLFigCTCGADiProPerm.m
%    in:        OODAbook\ChapterL
%

datafilestr = '..\..\DataSets\PanCancerData2' ;



%  Read in data
%
mdata = xlsread(datafilestr,'mdata') ;
caGeneName = xlsread(datafilestr,'caGeneName') ;
vOVflag = xlsread(datafilestr,'vOVflag') ;
mdataR = xlsread(datafilestr,'mdataR') ;
mdataT = xlsread(datafilestr,'mdataT') ;

disp(' ') ;
disp('    Data Read Finished') ;
disp(' ') ;

d = size(mdata,1) ;
n = size(mdata,2) ;

%  Create icolor & markerstr
%
icolor = [] ;
markerstr = [] ;
for i = 1:n ;
  if vOVflag(i) ;
    icolor = [icolor; [1 0 1]] ;
    markerstr = strvcat(markerstr,'o') ;
  else ;
    icolor = [icolor; [0 0.7 0]] ;
    markerstr = strvcat(markerstr,'+') ;
  end ;
end ;

legendcellstr = {{'OV' 'UCEC'}} ;
mlegendcolor = [[1 0 1]; ...
                [0 0.7 0]] ;


nsubset = 30 ;

seed = 0 ;
rng(seed) ;

vind = 1:n ;
vindOV = vind(vOVflag) ;
vindUCEC = vind(~vOVflag) ;
    %  overall indices in each type
nOV = sum(vOVflag) ;
nUCEC = sum(~vOVflag) ;
vindOVs = vindOV(randperm(nOV,nsubset)) ;
vindUCECs = vindUCEC(randperm(nUCEC,nsubset)) ;
    %  random subsets of overall indices

mdataOVs = mdata(:,vindOVs) ;
mdataROVs = mdataR(:,vindOVs) ;
mdataTOVs = mdataT(:,vindOVs) ;
mdataUCECs = mdata(:,vindUCECs) ;
mdataRUCECs = mdataR(:,vindUCECs) ;
mdataTUCECs = mdataT(:,vindUCECs) ;

icolors = [(ones(nsubset,1) * mlegendcolor(1,:)); ...
          (ones(nsubset,1) * mlegendcolor(2,:))] ;

markerstrs = [] ;
markerstrs2 = [] ;
for i = 1:nsubset ;
  markerstrs = strvcat(markerstrs,'o') ;
  markerstrs2 = strvcat(markerstrs2,'+') ;
end ;
markerstrs = strvcat(markerstrs,markerstrs2) ;



%  Run DiProPerm using MD
%
figure(1) ;
clf ;
paramstruct = struct('idir',2, ...
                     'istat',2, ...
                     'ishowperm',0, ...
                     'icolor',mlegendcolor, ...
                     'markerstr',['o'; '+'], ...
                     'iscreenwrite',1) ;
DiProPermSM(mdataOVs,mdataUCECs,paramstruct) ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig13p3A.png') ;


%  Run DiProPerm using DWD
%
figure(2) ;
clf ;
paramstruct = struct('idir',1, ...
                     'istat',2, ...
                     'ishowperm',0, ...
                     'icolor',mlegendcolor, ...
                     'markerstr',['o'; '+'], ...
                     'iscreenwrite',1) ;
DiProPermSM(mdataOVs,mdataUCECs,paramstruct) ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig13p3B.png') ;



