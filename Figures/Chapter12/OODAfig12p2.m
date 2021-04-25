disp('Running MATLAB script file OODAfig12p2.m') ;
%
%    Makes Figure 12.2 of the OODA book,
%    1-d illustration of 2 means clustering
%
%    Copied from OODAbookChpKFigIToyData1dCI.m
%    in:        OODAbook\ChapterK
%

%  Set initial quantities
%
figure(1) ;
clf ;
rng(38126347) ;

vdata = -20 + 1 * randn(1,5) ;
vdata = [vdata, (-2 + 0.1 * randn(1,1000))] ;
vdata = [vdata, (2 + 0.1 * randn(1,1000))] ;
vdata = [vdata, (20 + 1 * randn(1,5))] ;
n = length(vdata) ;
dataht = 0.65 + 0.15 * (1:n) / n ;

left = - 25 ;
right = 25 ;


%  Calculate base kernel density estimate
%
paramstruct = struct('vh',0.8, ...
                     'vxgrid',[left,right,401]) ;
[vkde,vsplit] = kdeSM(vdata',paramstruct) ;

visplit = 1:length(vsplit) ;
vkdes = 0.95 * (vkde / max(vkde)) ;
    %  rescaled version, to lie inside [0,1] scale


%  Loop through splits, make graphic when indicated
%
vCI = [] ;
for isplit = visplit ;

  disp(['  Working on split ' num2str(isplit) '  of ' num2str(visplit(end))]) ;

  split = vsplit(isplit) ;

  flag1 = vdata <= split ;
  flag2 = vdata > split ;
  vdata1 = vdata(flag1) ;
  vdata2 = vdata(flag2) ;

  dataht1 = dataht(flag1) ;
  dataht2 = dataht(flag2) ;

  if  isempty(vdata1)  |  isempty(vdata2) ;    %  Then just set cluster index to 1

    CI = 1 ;

  else ;    %  Then do the Cluster Index Calculation

    CI = ClustIndSM(vdata,flag1,flag2) ;

  end ;

  vCI = [vCI CI] ;

end ;


%  Make main plot
%
plot(vsplit,vkdes,'k-','LineWidth',2.5) ;
hold on ;
  plot(vdata,dataht,'k*') ;
  plot(vsplit,vCI,'r-','LineWidth',2.5) ;
hold off ;
axis([left,right,0,1]) ;


%  Add vertical bar showing one CI
%
hold on ;
  ind = 100 ;
  plot(vsplit(ind),vCI(ind),'bo','LineWidth',2,'MarkerSize',8) ;
  plot([vsplit(ind); vsplit(ind)],[0; 1],'b--','LineWidth',2) ;
hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig12p2.png') ;



