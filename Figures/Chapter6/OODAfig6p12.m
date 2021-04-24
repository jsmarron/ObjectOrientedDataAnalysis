disp('Running MATLAB script file OODAfig6p12.m') ;
%
%    Makes Figure 6.12 of the OODA book,
%    Combo View, Twin Arches Data, 2nd Mode of Variation
%
%    Copied from OODAbookChpFFigFcomboView.m
%    in:        OODAbook\ChapterF
%
%

datafilestr = '..\..\DataSets\TwinArchesData' ;


%  Set parameters
%
nmode = 2 ;
icolorhm = 2 ;
titlestr = 0 ;
    %  to completely turn off titles
xlabelstr = 'Curve #' ;
ylabelstr = 'Coordinate' ;


%  Read in data
%
mdata = xlsread(datafilestr) ;

d = size(mdata,1) ;
    %  dimension of each data curve
n = size(mdata,2) ;
    %  number of data curves


%  Sort data objects for nicer visualization
%
vmean = mean(mdata,1) ;
flag1 = vmean > 2.5 ;
flag2 = vmean < -2.5 ;
flag3 = (abs(vmean) <= 2.5) & (mdata(12,:) > 0) ;
flag4 = (abs(vmean) <= 2.5) & (mdata(12,:) < 0) ;
mdata = [mdata(:,flag1) mdata(:,flag2) mdata(:,flag3) mdata(:,flag4)] ;


%  Generate all 7 figures using ModeView.m
%
paramstruct = struct('iout',1, ...
                     'nmode',nmode, ...
                     'icolorhm',icolorhm, ...
                     'titlestr',titlestr, ...
                     'xlabelstr',xlabelstr, ...
                     'ylabelstr',ylabelstr) ;
ModeViewSM(mdata,paramstruct) ;


%  Save 4th figure for paper
%
figure(6) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig6p12.png') ;



