disp('Running MATLAB script file OODAfig6p14.m') ;
%
%    Makes Figure 6.14 of the OODA book,
%    Illustration of Orthogonal Axes
%
%    Copied from OODAbookChpFFigHNonOrthoAxes.m
%    in:        OODAbook\ChapterF
%
%

%  Set basics
%
n1 = 12 ;
n2 = 6 ;
mux = 4 ;
muy = 1 ;
rad = 0.6 ;
largeconst = 10 ;
alw = 2 ;
%{
mcol = [[1 0 0]; ...
        [0 0 1]; ...
        [0 0.7 0]; ...
        [0 0.7 0.7]] ;
%}
mcol = [[0 0.7 0.7]; ...
        [0 0 1]; ...
        [0.7 0.7 0]; ...
        [1 0 0]] ;


%  Generate Data
%
vang1 = 2 * pi * linspace(1,n1,n1) / n1 ;
mdata1 = [(mux * ones(1,n1) + rad * cos(vang1)); ...
          (muy * ones(1,n1) + rad * sin(vang1))] ;
mdata2 = [(-mux * ones(1,n1) + rad * cos(vang1)); ...
          (-muy * ones(1,n1) + rad * sin(vang1))] ;
vang2 = 2 * pi * linspace(1,n2,n2) / n2 ;
mdata3 = [(mux * ones(1,n2) + rad * cos(vang2)); ...
          (-muy * ones(1,n2) + rad * sin(vang2))] ;
mdata4 = [(-mux * ones(1,n2) + rad * cos(vang2)); ...
          (muy * ones(1,n2) + rad * sin(vang2))] ;
vaxdata = axisSM([mdata1(1,:) mdata2(1,:) mdata3(1,:) mdata4(1,:)], ...
                 [mdata1(2,:) mdata2(2,:) mdata3(2,:) mdata4(2,:)]) ;

vmean1 = mean(mdata1,2) ;
vmean2 = mean(mdata2,2) ;
vmean3 = mean(mdata3,2) ;
vmean4 = mean(mdata4,2) ;

vdir12 = vmean1 - vmean2 ;
vdir12 = vdir12 / norm(vdir12) ;
    %  Direction Vector from 2 to 1
vdir12o = [-vdir12(2); vdir12(1)] ;
    %  Direction Vector Orthogonal to vector from 2 to 1
vdir34 = vmean3 - vmean4 ;
vdir34 = vdir34 / norm(vdir34) ;
    %  Direction Vector from 2 to 1
vdir34o = [-vdir34(2); vdir34(1)] ;
    %  Direction Vector Orthogonal to vector from 4 to 3

vproj12d1 = vdir12' * mdata1 ;
vproj12d2 = vdir12' * mdata2 ;
vproj12d3 = vdir12' * mdata3 ;
vproj12d4 = vdir12' * mdata4 ;
    %  projections of data onto 12 direction
vax12 = axisSM([vproj12d1 vproj12d2 vproj12d3 vproj12d4]) ;

vproj12od1 = vdir12o' * mdata1 ;
vproj12od2 = vdir12o' * mdata2 ;
vproj12od3 = vdir12o' * mdata3 ;
vproj12od4 = vdir12o' * mdata4 ;
    %  projections of data onto orthogonal 12 direction
vax12o = axisSM([vproj12od1 vproj12od2 vproj12od3 vproj12od4]) ;

vproj34d1 = vdir34' * mdata1 ;
vproj34d2 = vdir34' * mdata2 ;
vproj34d3 = vdir34' * mdata3 ;
vproj34d4 = vdir34' * mdata4 ;
    %  projections of data onto 12 direction
vax34 = axisSM([vproj34d1 vproj34d2 vproj34d3 vproj34d4]) ;

vproj34od1 = vdir34o' * mdata1 ;
vproj34od2 = vdir34o' * mdata2 ;
vproj34od3 = vdir34o' * mdata3 ;
vproj34od4 = vdir34o' * mdata4 ;
    %  projections of data onto orthogonal 12 direction
vax34o = axisSM([vproj34od1 vproj34od2 vproj34od3 vproj34od4]) ;

vproj12dir34 = [(vdir12' * vdir34); (vdir12o' * vdir34)] ;
    % projections of vdir34 onto vdir12 axes
vproj34dir12 = [(vdir34o' * vdir12); (vdir34' * vdir12)] ;
    % projections of vdir12 onto vdir34 axes

vlineends12 = [[-largeconst * vdir12] [largeconst * vdir12]] ;
vlineends34 = [[-largeconst * vdir34] [largeconst * vdir34]] ;
vlineends1234 = [[-largeconst * vproj12dir34] [largeconst * vproj12dir34]] ;
vlineends3412 = [[-largeconst * vproj34dir12] [largeconst * vproj34dir12]] ;
    %  Endpoints for plotting lines


%  Create Graphics
%
figure(1) ;
clf ;

subplot(2,2,1) ;
  plot(mdata1(1,:),mdata1(2,:),'+','Color',mcol(1,:)) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'+','Color',mcol(2,:)) ;
    plot(mdata3(1,:),mdata3(2,:),'o','Color',mcol(3,:)) ;
    plot(mdata4(1,:),mdata4(2,:),'o','Color',mcol(4,:)) ;
    plot(vlineends12(1,:),vlineends12(2,:),'k-','LineWidth',alw) ;
    plot(vlineends34(1,:),vlineends34(2,:),'k-.','LineWidth',alw) ;
    plot(vlineends12(2,:),-vlineends12(1,:),'k--','LineWidth',alw) ;
  hold off ;
  axis(vaxdata) ;
  axis equal ;
  xlabel('x') ;
  ylabel('y') ;

subplot(2,2,2) ;
  plot(vproj12d1,vproj34d1,'+','Color',mcol(1,:)) ;
  hold on ;
    plot(vproj12d2,vproj34d2,'+','Color',mcol(2,:)) ;
    plot(vproj12d3,vproj34d3,'o','Color',mcol(3,:)) ;
    plot(vproj12d4,vproj34d4,'o','Color',mcol(4,:)) ;
    plot([-largeconst; largeconst],[0; 0],'k-','LineWidth',alw) ;
    plot([0; 0],[-largeconst; largeconst],'k-.','LineWidth',alw) ;
  hold off ;
  axis([vax12 vax34]) ;
  axis equal ;
  xlabel('Blue-Cyan Scores') ;
  ylabel('Red-Yellow Scores') ;

subplot(2,2,3) ;
  plot(vproj12d1,vproj12od1,'+','Color',mcol(1,:)) ;
  hold on ;
    plot(vproj12d2,vproj12od2,'+','Color',mcol(2,:)) ;
    plot(vproj12d3,vproj12od3,'o','Color',mcol(3,:)) ;
    plot(vproj12d4,vproj12od4,'o','Color',mcol(4,:)) ;
    plot([-largeconst; largeconst],[0; 0],'k-','LineWidth',alw) ;
    plot([0; 0],[-largeconst; largeconst],'k--','LineWidth',alw) ;
    plot(vlineends1234(1,:),vlineends1234(2,:),'k-.','LineWidth',alw) ;
  hold off ;
  axis([vax12 vax12o]) ;
  axis equal ;
  xlabel('Blue-Cyan Scores') ;
  ylabel('Ortho. Blue-Cyan Scores') ;

subplot(2,2,4) ;
  plot(vproj34d1,vproj34od1,'+','Color',mcol(1,:)) ;
  hold on ;
    plot(vproj34d2,vproj34od2,'+','Color',mcol(2,:)) ;
    plot(vproj34d3,vproj34od3,'o','Color',mcol(3,:)) ;
    plot(vproj34d4,vproj34od4,'o','Color',mcol(4,:)) ;
    plot([-largeconst; largeconst],[0; 0],'k-.','LineWidth',alw) ;
    plot(vlineends3412(2,:),vlineends3412(1,:),'k-','LineWidth',alw) ;
  hold off ;
  axis([vax34 vax34o]) ;
  axis equal ;
  xlabel('Red-Yellow Scores') ;
  ylabel('Ortho. Red-Yellow Scores') ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig6p14.png') ;



