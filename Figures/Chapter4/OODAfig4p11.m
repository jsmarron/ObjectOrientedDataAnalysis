disp('Running MATLAB script file OODAfig4p11.m') ;
%
%    Makes Figure 4.11 of the OODA book,
%    Pan Cancer Data, subsetted to 50 each from 6 types
%    DWD Loadings for KIRC vs. HNSC
%
%    Copied from OODAbookChpBFigX.m
%    in:        OODAbook\ChapterB
%


%  Read in data
%
mdata = xlsread('..\..\DataSets\PanCancerData.xlsx','Sheet1','B3:KO12480') ;
[nundata,varnamecellstr] = xlsread('..\..\DataSets\PanCancerData.xlsx','Sheet1','A3:A12480') ;

d = size(mdata,1) ;
    %  dimension of each data curve
n = size(mdata,2) ;
    %  number of data curves


nct = 50 ;
mCTflag = zeros(6,n) ;
ipb = 0 ;
    %  index of end to previous block
for i = 1:6 ;
  mCTflag(i,(ipb + 1):(ipb + nct)) = ones(nct,1) ;
  ipb = ipb + nct ;
end ;
mCTflag = logical(mCTflag) ;

mind = [[4 2]; [1 5]; [6 3]] ;
    %caCTnamebase = {'BLCA' 'KIRC' 'OV' 'HNSC' 'COAD' 'BRCA'} ;

%  Compute Directions etc.
%
mDWDdirn = [] ;
for irow = 1:size(mind,1) ;
  DWDdirn = DWD2XQ(mdata(:,mCTflag(mind(irow,1),:)), ...
                   mdata(:,mCTflag(mind(irow,2),:))) ;
  mDWDdirn = [mDWDdirn DWDdirn] ;
end ;
meigvec = mDWDdirn ;


%  Generate graphics
%
figure(1) ;
clf ;

disp('Making Labelled Bar Plots of Loadings') ;
disp(' ') ;
subplot(2,1,2) ;
  paramstruct = struct('isort',2, ...
                       'nshow',20, ...
                       'fontsize',12) ;
  LabeledBarPlotSM(meigvec(:,1),varnamecellstr,paramstruct) ;


disp('Making Sorted Loadings Curve') ;
disp(' ') ;
subplot(2,1,1) ;
  vsortload = sort(meigvec(:,1),'descend') ;
  plot((1:d)',vsortload,'g-','linewidth',3) ;
  vax = axisSM(vsortload) ;
  axis([0 (d + 1) vax(1) vax(2)]) ;
  hold on ;
    plot([0; (d + 1)],[0; 0],'k-') ;
    xlabel('Index') ;
    ylabel('Loading') ;
  hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig4p11.png') ;

