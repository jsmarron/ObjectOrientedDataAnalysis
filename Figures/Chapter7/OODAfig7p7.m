disp('Running MATLAB script file OODAfig7p7.m') ;
%
%    Makes Figure 7.7 of the OODA book,
%    Illustrates PCA Columns as Data Objects
%
%    Copied from OODAbookChpEFigEDistColsDataObjects.m
%    in:        OODAbook\ChapterE
%


%  Generate Data
%
n = 100 ;
rng(13861576) ;
mdata = randn(2,n) ;
mdata(1,:) = 2 * mdata(1,:) ;
[temp,visort] = sort(mdata(1,:)) ;
mdatas = mdata(:,visort) ;
theta = pi / 6 ;
mdatas = [[cos(theta) -sin(theta)]; [sin(theta) cos(theta)]] * mdatas ;


%  Compute Distance matrix
%
mxdiff = (ones(n,1) * mdatas(1,:)) - (mdatas(1,:)' * ones(1,n)) ; 
mydiff = (ones(n,1) * mdatas(2,:)) - (mdatas(2,:)' * ones(1,n)) ; 
mdist = sqrt(mxdiff.^2 + mydiff.^2) ;

mdscoord = mdscale(mdist,2)' ;
    %  MDS coords


%  Generate Figure 2
figure(2) ;
clf ;
labelcellstr = {{'PC 1 Scores' 'PC 2 Scores' 'PC 3 Scores'}} ;

paramstruct = struct('npcadiradd',3, ...
                     'icolor',2, ...
                     'markerstr','x', ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(mdist,[],paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig7p7.png') ;



