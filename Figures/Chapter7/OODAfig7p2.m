disp('Running MATLAB script file OODAfig7p2.m') ;
%
%    Makes Figure 7.2 of the OODA book,
%    Illustrates Frechet Median
%
%    Copied from OODAbookChpEFigCToyL2FrechetMedian.m
%    in:        OODAbook\ChapterE
%


%  Set up preliminaries
%
mdata = [[0.10 0.75]; ...
         [0.33 0.83]; ...
         [0.21 0.64]; ...
         [0.48 0.90]; ...
         [0.76 0.10]] ;

n = size(mdata,1) ;
d = size(mdata,2) ;

CandPoint1 = [0.9 0.3] ;
vmedian = rmeanSM(mdata) ;


%  Do preliminary calculations
%
FSS1 = 0 ;
FSSm = 0 ;
for i = 1:n ;
  FSS1 = FSS1 + sqrt((mdata(i,1) - CandPoint1(1))^2 + (mdata(i,2) - CandPoint1(2))^2) ;
  FSSm = FSSm + sqrt((mdata(i,1) - vmedian(1))^2 + (mdata(i,2) - vmedian(2))^2) ;
end ;


%  Preliminary graphics quantities
%
datalw = 1.5 ;
datams = 6 ; 
pointlw = 3 ;
pointms = 10 ; 
labfontsize = 10 ;
linelw = 2 ;
meancolor = [0 0.7 0] ;


figure(1) ;
clf ;

subplot(1,2,1) ;    %  make Candidate1 plot
  plot(mdata(:,1),mdata(:,2),'ko','LineWidth',datalw,'MarkerSize',datams) ;
  hold on ;
    plot(CandPoint1(1),CandPoint1(2),'bx','LineWidth',pointlw,'MarkerSize',pointms) ;
    plot([mdata(:,1)'; (ones(1,n) * CandPoint1(1))], ...
         [mdata(:,2)'; (ones(1,n) * CandPoint1(2))], ...
         'b-','LineWidth',linelw) ;
    text(0.1,0.1,['Frechet Sum = ' num2str(FSS1,2)],  ...
         'Color','b','FontSize',labfontsize) ;
  hold off ;
  axis([0 1 0 1]) ;
  axis square ;


subplot(1,2,2) ;    %  make median plot
  plot(mdata(:,1),mdata(:,2),'ko','LineWidth',datalw,'MarkerSize',datams) ;
  hold on ;
    plot(vmedian(1),vmedian(2),'x','LineWidth',pointlw,'MarkerSize',pointms, ...
         'Color',meancolor) ;
    plot([mdata(:,1)'; (ones(1,n) * vmedian(1))], ...
         [mdata(:,2)'; (ones(1,n) * vmedian(2))], ...
         '-','LineWidth',linelw,'Color',meancolor) ;
    text(0.1,0.1,['Frechet Sum = ' num2str(FSSm,2)],  ...
         'Color',meancolor,'FontSize',labfontsize) ;
  hold off ;
  axis([0 1 0 1]) ;
  axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig7p2.png') ;



