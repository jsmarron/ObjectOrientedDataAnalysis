disp('Running MATLAB script file OODAfig10p5.m') ;
%
%    Makes Figure 10.5 of the OODA book,
%    Illustration of TDA filtration
%
%    Copied from OODAbookChpIFigEToyFiltration.m
%    in:        OODAbook\ChapterI
%

%  Create raw data points
%
cent1 = [5; 5] ;
r1 = 2 ;
nang1 = 5 ;
vang1 = 2 * pi * (0:(nang1 - 1)) / nang1 ;
mcent1 = [(cent1(1) * ones(1,nang1) + r1 * cos(vang1)); ...
         (cent1(2) * ones(1,nang1) + r1 * sin(vang1))] ;

cent2 = [13; 5] ;
r2 = 2.5 ;
nang2 = 10 ;
vang2 = 2 * pi * (0:(nang2 - 1)) / nang2 ;
mcent2 = [(cent2(1) * ones(1,nang2) + r2 * cos(vang2)); ...
         (cent2(2) * ones(1,nang2) + r2 * sin(vang2))] ;

mcent = [mcent1 mcent2] ;
nc = size(mcent,2) ;

%  Create patch template
%
np = 40 ;
vangp = 2 * pi * (0:np) / np ;
vrp = (0.5:0.1:3) ;
nrp = length(vrp) ;


%  Generate Graphics
%
figure(1) ;
clf ;
glev = 0.2 ;

left = 0 ;
right = 24.4 ;
bottom = 0 ;
top = 10 ;


%  Create box and bar graph
%
vboxx = [19; 19; 24; 24; 19] ;
vboxy = [0; 10; 10; 0; 0] ;

vbar0x = 19 + 4 * ((1:13) / 13) ;
vbar0max = [3 1.75 (1.13 * ones(1,4)) (0.79 * ones(1,7))] ;
vbar0max = vbar0max * 10 / 3 ;

vbar1x = 23.2 + 4 * ((1:2) / 13) ;
vbar1min = [0.79 1.17] * 10 / 3 ;
vbar1max = [2.44 1.96] * 10 / 3 ;


for ip = 1:nrp ;

  rs = vrp(ip) * 10 / 3 ;
  vbar0 = min(vbar0max,rs) ;
  vbar1 = min(vbar1max,rs) ;

  plot(mcent(1,:),mcent(2,:),'k+','MarkerSize',10,'LineWidth',3) ;
  axis equal ;
  axis([left, right, bottom, top]) ;
  axis off ;

  hold on ;
    plot(1,5,'k.','MarkerSize',1) ;
    plot(vboxx,vboxy,'k-') ;
    plot([18.8; 24.2],[rs; rs],'k-','LineWidth',2) ;
    plot([vbar0x; vbar0x],[zeros(1,13); vbar0],'k-','LineWidth',3) ;
    if rs > vbar1min(1) ;    %  draw 1st 1 bar
      plot([vbar1x(1); vbar1x(1)],[vbar1min(1); vbar1(1)],'k:','LineWidth',3) ;
    end ;
    if rs > vbar1min(2) ;    %  draw 2nd 1 bar
      plot([vbar1x(2); vbar1x(2)],[vbar1min(2); vbar1(2)],'k:','LineWidth',3) ;
    end ;
    for ic = 1:nc ;
      vpx = mcent(1,ic) * ones(1,np + 1) + vrp(ip) * cos(vangp) ;
      vpy = mcent(2,ic) * ones(1,np + 1) + vrp(ip) * sin(vangp) ;
      ph = patch(vpx,vpy,[glev glev glev]) ;
      set(ph,'FaceAlpha',0.1) ;
    end ;
  hold off ;


  %  Create needed png files
  %
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 3.5]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.0]) ; 

  if vrp(ip) == 1 ;    %  disc radius = 1
    print('-dpng','OODAfig10p5A.png') ;
  elseif  vrp(ip) == 1.5 ;    %  disc radius = 1.5
    print('-dpng','OODAfig10p5B.png') ;
  elseif  vrp(ip) == 2.1 ;    %  disc radius = 2.1
    print('-dpng','OODAfig10p5C.png') ;
  end ;


end ;



