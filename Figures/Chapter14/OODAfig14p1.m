disp('Running MATLAB script file OODAfig14p1.m') ;
%
%    Makes Figure 14.1 of the OODA book,
%    Motivation of Marcenko Pastur distribution from scree plots
%
%    Copied from OODAbookChpMFigDScree2MP.m
%    in:        OODAbook\ChapterM
%

%  Start graphics
%
figure(1) ;
clf ;

subplot(1,3,1) ;    %  Show different settings
  d = 100 ;
  vn = [100 300 1000 10000] ;
  nn = length(vn) ;
  vind = (1:d)' ;
  mcol = [[0 0 0]; ...
          [1 0 0]; ...
          [0 0 1]; ...
          [0 1 0]] ;
  fs = 10 ;    %  Font Size for Axis Labels
  ms = 4 ;    %  Marker Size
  seed = 12452987 ;
  rng(seed) ;
  disp(' ') ;
  hold on ;
    for in = 1:nn ;
      n = vn(in) ;
      disp(['    Working on n = ' num2str(n)]) ;
      mdat = randn(d,n) ;
      veig = eig(mdat * mdat') ;
      veig = flipud(veig / n) ;
      plot(vind,veig,'o','Color',mcol(in,:),'MarkerSize',ms) ;
    end ;
    xlabel('index j','FontSize',fs) ;
    ylabel('eigenvalue','FontSize',fs) ;
    plot([0; 101],[1; 1],'k--') ;
  hold off ;
  axis([0 (d + 1) 0 4]) ;


subplot(1,3,2) ;    %  Show equivalent settings
  vd = [100 400 1600] ;
  vn = [500 2000 8000] ;
  nn = length(vn) ;
  mcol = [[1 0 1]; ...
          [0 0.8 0.8]; ...
          [1 1 0]] ;
  fs = 10 ;    %  Font Size for Axis Labels
  vms = [7 3 1] ;    %  Marker Size
  seed = 98764985 ;
  disp(' ') ;
  hold on ;
    for in = 1:nn ;
      n = vn(in) ;
      d = vd(in) ;
      vindoi = (1:d)' / d ;
      disp(['    Working on n = ' num2str(n) ', d = ' num2str(d)]) ;
      mdat = randn(d,n) ;
      veig = eig(mdat * mdat') ;
      veig = flipud(veig / n) ;
      plot(vindoi,veig,'o','Color',mcol(in,:),'MarkerSize',vms(in)) ;
    end ;
    xlabel('(index j) / d','FontSize',fs) ;
    ylabel('eigenvalue','FontSize',fs) ;
    plot([0; 101],[1; 1],'k--') ;
  hold off ;
  axis([0 1.01 0 2.2]) ;


subplot(1,3,3) ;    %  Show scree to histogram
  d = 400 ;
  n = 2000 ;
  vcol = [0 0.8 0.8] ;
  fs = 10 ;    %  Font Size for Axis Labels
  vms = 3 ;    %  Marker Size
  seed = 54872365 ;
  rng(seed) ;
  vind = (1:d)' ;
  mdat = randn(d,n) ;
  veig = eig(mdat * mdat') ;
  veig = flipud(veig / n) ;
  plot(vind,veig,'o','Color',vcol,'MarkerSize',ms) ;
  xlabel('index j','FontSize',fs) ;
  ylabel('eigenvalue','FontSize',fs) ;
  hold on ;
    plot([0; (d + 1)],[1; 1],'k--') ;
  hold off ;
  axis([0 (d + 1) 0 2.2]) ;
  vax = axis ;

  %  Bin using lines from HeatMapSM.m
  % 
  nbin = 50 ;
  cntscalefact = 10 ;
      %  factor by which to scale the counts, for visual effect
  del = (vax(4) - vax(3)) / (nbin - 2) ;
      %  width of each bin
  vedges = linspace(vax(3),vax(4),nbin - 1) ;
      %  vector of edges between each bin
  vcts = histc(veig(1:(d - 1)),[-inf vedges inf]) ;
      %  vector of bin counts
  vedgesp = [(vax(3) - del) vedges (vax(4) + del)] ;
      %  vector of edges for plotting
  hold on ;
%    plot([vax(1); vax(2)],[0; 0],'k-') ;    %  add x axis
%    plot([0; 0],[vax(3); vax(4)],'k-') ;    %  add y axis
%    plot([vax(1); vax(2)],[1; 1],'k--') ;    %  add dashed line at height 1
    for ib = 1:nbin ;    %  Plot patches for sideways histogram
      h = patch((cntscalefact * [0; vcts(ib); vcts(ib); 0; 0]), ...
            [vedgesp(ib); vedgesp(ib); vedgesp(ib + 1); ...
                                 vedgesp(ib + 1); vedgesp(ib)], ...
            [0.7 0.7 0.7],'FaceAlpha',0.5) ;
    end ;
  hold off ;

  %  Add scaled Marcenko Pasteur
  %
  c = d / n ;
  a = (1 - sqrt(c))^2 ;
  b = (1 + sqrt(c))^2 ;
  xgrid = linspace(a,b,401) ;
  LSD = sqrt((b - xgrid) .* (xgrid - a)) ./ (2 * pi * c * xgrid) ;
  MPfact = 178 ;
  hold on ;
    plot(MPfact * LSD,xgrid,'k-') ;
  hold off ;



%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig14p1.png') ;




