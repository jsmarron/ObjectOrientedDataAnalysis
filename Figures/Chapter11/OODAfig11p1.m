disp('Running MATLAB script file OODAfig11p1.m') ;
%
%    Makes Figure 11.1 of the OODA book,
%    Shifted Correlated Gaussians Data
%    Poor Mean Difference Analysis
%
%    Copied from OODAbookChpJFigAWhyNotMD.m
%    in:        OODAbook\ChapterJ
%

 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic


datafilestr = '..\..\DataSets\ShiftedCorrelatedGaussiansData' ;

n = 100 ;



if ipart == 0 ;    %  Generate and save data

  %  Set Common Quantities
  %
  seed = 20943343 ;
  randn('seed',seed) ;

  %  generate data
  %
  data1 = randn(n,1) ;
  data1 = [1.3 + data1, (0 + data1 + 0.2 * randn(n,1))] ;
  data2 = randn(n,1) ;
  data2 = [-0.7 + data2, (0 + data2 + 0.2 * randn(n,1))] ;

  xlswrite([datafilestr '.xlsx'],data1,'data1') ;
  xlswrite([datafilestr '.xlsx'],data2,'data2') ;


else ;    %  Make main graphic

  %  Read in data
  %
  data1 = xlsread(datafilestr,'data1') ;
  data2 = xlsread(datafilestr,'data2') ;


  %  Make main graphic
  %
  figure(1) ;
  clf ;


  %  Compute Direction Vectors
  %
  vmean1 = mean(data1',2) ;
  vmean2 = mean(data2',2) ;
  mdata = [data1' data2'] ;
  vmean = mean([vmean1 vmean2],2) ;

  vdir = (vmean1 - vmean2) ;
            %  Direction Vector
  vdir = vdir / norm(vdir) ;
            %  make it a unit vector
  dirov = [-vdir(2); vdir(1)] ;
  mdirvec = [(vmean + 2 * vdir), (vmean - 10 * dirov), (vmean + 10 * dirov)] ;


  subplot(1,2,1) ;
    plot(data1(:,1),data1(:,2),'r.', ...
         data2(:,1),data2(:,2),'b.', ...
         [[0;0], [-4;4]],[[-4;4], [0;0]],'w-', ...
                'MarkerSize',10) ;
    hold on ;
      plot([vmean(1) ; mdirvec(1,1)], ...
           [vmean(2) ; mdirvec(2,1)], ...
               'g-','LineWidth',3) ;
      plot([mdirvec(1,3) ; mdirvec(1,2)],[mdirvec(2,3); mdirvec(2,2)], ...
               'g--','LineWidth',2) ;
      plot([vmean(1) vmean1(1) vmean2(1)], ...
           [vmean(2) vmean1(2) vmean2(2)], 'go', ...
            'LineWidth',2,'MarkerSize',12) ;
      plot([vmean1(1) vmean2(1)], ...
           [vmean1(2) vmean2(2)], 'gx', ...
            'LineWidth',2,'MarkerSize',12) ;
      plot(vmean(1),vmean(2), 'g+', ...
            'LineWidth',2,'MarkerSize',12) ;
    hold off ;
    axis equal ;
    axis([-4,4,-4,4]) ;
    axis off ;


  subplot(1,2,2) ;
    mcolor = [(ones(n,1) * [1 0 0]); (ones(n,1) * [0 0 1])] ;
    paramstruct = struct('icolor',mcolor, ...
                         'markerstr','.', ...
                         'isubpopkde',1, ...
                         'ibigdot',0, ...
                         'iscreenwrite',1) ;
    projplot1SM([data1' data2'],vdir,paramstruct) ;



  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
  print('-dpng','OODAfig11p1.png') ;


end ;

