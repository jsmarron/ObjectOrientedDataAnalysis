disp('Running MATLAB script file OODAfig7p5.m') ;
%
%    Makes Figure 7.5 of the OODA book,
%    Illustrates MDS - PCA Connection
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


%  Generate Figure 1
figure(1) ;
clf ;

subplot(1,2,1) ;
paramstruct = struct('icolor',2, ...
                     'markerstr','+', ...
                     'vaxlim',[-5.5 5.5 -5.5 5.5], ...
                     'xlabelstr','x', ...
                     'ylabelstr','y', ...
                     'iscreenwrite',1) ;
projplot2SM(mdatas,eye(2),paramstruct) ;
axis square ;

subplot(1,2,2) ;
paramstruct = struct('icolor',2, ...
                     'markerstr','o', ...
                     'vaxlim',[-5.5 5.5 -5.5 5.5], ...
                     'xlabelstr','1st MDS Coord', ...
                     'ylabelstr','2nd MDS Coord', ...
                     'iscreenwrite',1) ;
projplot2SM(mdscoord,eye(2),paramstruct) ;
axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig7p5.png') ;



