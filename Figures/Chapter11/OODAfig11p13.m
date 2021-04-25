disp('Running MATLAB script file OODAfig11p13.m') ;
%
%    Makes Figure 11.13 of the OODA book,
%    DWD vs. SVM on PanCan Data
%
%    Copied from OODAbookChpJFigIBadSVMvis.m
%    in:        OODAbook\ChapterJ
%

datafilestr = '..\..\DataSets\PanCancerData' ;

%  Read in data
%
mdata = xlsread(datafilestr) ;

n = size(mdata,2) ;

%  Set colors and markers
%
mcolorbase = RainbowColorsQY(6) ;
mcolorbase(5,:) = [0.8 0.8 0] ;
    %  Make Yellow color for COAD a bit darker
caCTnamebase = {'BLCA' 'KIRC' 'OV' 'HNSC' 'COAD' 'BRCA'} ;


mcolor = zeros(n,3) ;
markerstr = [] ;
for itype = 1:6 ;
  for id = 1:50 ;
    i = id + (itype - 1) * 50 ;
    if itype == 1 ;    %  BLCA
      mcolor(i,:) = mcolorbase(1,:) ;
      markerstr = strvcat(markerstr,'s') ;
    elseif itype == 2 ;    %  KIRC  
      mcolor(i,:) = mcolorbase(2,:) ;
      markerstr = strvcat(markerstr,'d') ;
    elseif itype == 3 ;    %  OV
      mcolor(i,:) = mcolorbase(3,:) ;
      markerstr = strvcat(markerstr,'x') ;
    elseif itype == 4 ;    %  HNSC
      mcolor(i,:) = mcolorbase(4,:) ;
      markerstr = strvcat(markerstr,'*') ;
    elseif itype == 5 ;    %  COAD
      mcolor(i,:) = mcolorbase(5,:) ;
      markerstr = strvcat(markerstr,'+') ;
    elseif itype == 6 ;    %  BRCA
      mcolor(i,:) = mcolorbase(6,:) ;
      markerstr = strvcat(markerstr,'o') ;
    end ;
  end ;
end ;


vnCT = [50 50 50 50 50 50] ;
nct = length(caCTnamebase) ;
mCTflag = zeros(length(caCTnamebase),n) ;
ipb = 0 ;
    %  index of end to previous block
for i = 1:length(caCTnamebase) ;
  mCTflag(i,(ipb + 1):(ipb + vnCT(i))) = ones(vnCT(i),1) ;
  ipb = ipb + vnCT(i) ;
end ;
mCTflag = logical(mCTflag) ;

mind = [[4 2]; [1 5]; [6 3]] ;

%  Compute Directions etc.
%
mDWDdirn = [] ;
mSVMdirn = [] ;
for irow = 1:size(mind,1) ;

  DWDdirn = DWD2XQ(mdata(:,mCTflag(mind(irow,1),:)), ...
                   mdata(:,mCTflag(mind(irow,2),:))) ;
  mDWDdirn = [mDWDdirn DWDdirn] ;

  SVMdirn = SVM1SM(mdata(:,mCTflag(mind(irow,1),:)), ...
                   mdata(:,mCTflag(mind(irow,2),:))) ;
  mSVMdirn = [mSVMdirn SVMdirn] ;

end ;


figure(1) ;
clf ;

subplot(1,2,1) ;
  labelcellstr = {{[caCTnamebase{mind(1,1)} ' vs. ' caCTnamebase{mind(1,2)} ' DWD']; ...
                   [caCTnamebase{mind(2,1)} ' vs. ' caCTnamebase{mind(2,2)} ' DWD']; ...
                   [caCTnamebase{mind(3,1)} ' vs. ' caCTnamebase{mind(3,2)} ' DWD']}} ;

  paramstruct = struct('icolor',mcolor, ...
                       'markerstr',markerstr, ...
                       'xlabelstr',labelcellstr{1}{2}, ...
                       'ylabelstr',labelcellstr{1}{3}, ...
                       'iscreenwrite',1) ;
  projplot2SM(mdata,mDWDdirn(:,[2 3]),paramstruct) ;


subplot(1,2,2) ;
  labelcellstr = {{[caCTnamebase{mind(1,1)} ' vs. ' caCTnamebase{mind(1,2)} ' SVM']; ...
                   [caCTnamebase{mind(2,1)} ' vs. ' caCTnamebase{mind(2,2)} ' SVM']; ...
                   [caCTnamebase{mind(3,1)} ' vs. ' caCTnamebase{mind(3,2)} ' SVM']}} ;

  paramstruct = struct('icolor',mcolor, ...
                       'markerstr',markerstr, ...
                       'xlabelstr',labelcellstr{1}{2}, ...
                       'ylabelstr',labelcellstr{1}{3}, ...
                       'iscreenwrite',1) ;
  projplot2SM(mdata,mSVMdirn(:,[2 3]),paramstruct) ;



%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig11p13.png') ;



