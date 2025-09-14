disp('Running MATLAB script file PCAPLSCCAOODAfig17p8.m') ;
%
%    Makes Multiple Graphics for Showing Rotations
%    of Toy Example Comparing PCA, PLS, CCA
%
%    Copied from OODAfig17p8.m, which
%    Mades Figure 17.8 of the OODA book,
%    Toy Example, contrasting PCA - PLS - CCA
%
%    Copied from OODAbookChpPFigDPLSvCCA.m
%    in:        OODAbook\ChapterP
%


%  Version with two view angles, combined planes
%  Set parameters
%
n = 100 ;
rng(39487253) ;
viewang1 = 220 ;    %  1st view angle in degrees
viewang2 = 170 ;    %  2nd view angle in degrees
axl = 3 ;    %  (half) axis length
pl = 2.5 ;    %  (half) patch length
msize = 4 ;
mlw = 1 ;
alw = 2 ;
llw = 3 ;
fsize = 10 ;

%  Generate Data
%
mdata = randn(1,n) ;
mdata = [mdata; (mdata + 0.3 * randn(1,n))] ;
mdata = [mdata; (mdata(2,:) - mdata(1,:))] ;
mdata = mdata - vec2matSM(mean(mdata,2),n) ;
    %  Exactly Mean Centered
theta = 15 * pi / 180 ;
mrot = [[cos(theta) sin(theta)] ; ...
        [-sin(theta) cos(theta)]] ;
mdata([1 2],:) = mrot * mdata([1 2],:) ;

%  Compute PC1, PLS and CCA directions
%
paramstruct = struct('npc',1, ...
                     'iscreenwrite',1, ...
                     'viout',[0 1]) ;
outstruct = pcaSM(mdata(1:2,:),paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;
PC1dir = axl * meigvec ;
    %  no - sign, so fits best with other directions
crosscov = mdata(3,:) * mdata([1 2],:)' ;
PLSdir = axl * crosscov / norm(crosscov) ;
xcov = mdata([1 2],:) * mdata([1 2],:)' ;
CCAdir = crosscov * sqrtm(inv(xcov)) ;
CCAdir = axl * CCAdir / norm(CCAdir) ;

%  Compute 3-d PCA
%
paramstruct = struct('npc',2, ...
                     'iscreenwrite',1, ...
                     'viout',[1 1 0 0 1]) ;
outstruct = pcaSM(mdata,paramstruct) ;
veigval = getfield(outstruct,'veigval') ;
meigvec = getfield(outstruct,'meigvec') ;
mpc = getfield(outstruct,'mpc') ;
s1 = sqrt(veigval(1)) ;
s2 = sqrt(veigval(2)) ;
mpatchc = axl * [s1 * meigvec(:,1)' + s2 * meigvec(:,2)'; ...
           s1 * meigvec(:,1)' - s2 * meigvec(:,2)'; ...
           -s1 * meigvec(:,1)' - s2 * meigvec(:,2)'; ...
           -s1 * meigvec(:,1)' + s2 * meigvec(:,2)'; ...
           s1 * meigvec(:,1)' + s2 * meigvec(:,2)'] ;
    %  5 x 3 matrix of patch corners
mline = 1.05 * axl * s1 * [-meigvec(:,1) meigvec(:,1)] ;
    %  2 x 3 matrix of intersection line


nv = 6 ;
vviewang = linspace(viewang1,viewang2,nv) ;

for iv = 1:nv

  viewang = vviewang(iv) ;

  fighand = figure(1) ;
  clf ;

  plot3(mdata(1,:),mdata(2,:),mdata(3,:),'k+', ...
            'MarkerSize',msize,'LineWidth',mlw) ;
  hold on ;
    plot3([-axl;axl],[0;0],[0;0],'k-','LineWidth',alw) ;
    plot3([0;0],[-axl,axl],[0;0],'k-','LineWidth',alw) ;
    plot3([0;0],[0;0],[-axl,axl],'k-','LineWidth',alw) ;
    text(axl,0,0,'x_1','Color','k','FontSize',fsize) ;
    text(0,axl,0,'x_2','Color','k','FontSize',fsize) ;
    text(0,0,axl,'y','Color','k','FontSize',fsize) ;
    plot3([0;PC1dir(1)],[0;PC1dir(2)],[0;0],'r-','LineWidth',llw) ;
    plot3([0;PLSdir(1)],[0;PLSdir(2)],[0;0],'g-','LineWidth',llw) ;
    plot3([0;CCAdir(1)],[0;CCAdir(2)],[0;0],'b-','LineWidth',llw) ;
    text(1.6 * PC1dir(1),1.6 * PC1dir(2),0, ...
                'PC1','Color','r','FontSize',fsize) ;
    text(1.2 * PLSdir(1),1.2 * PLSdir(2),0, ...
                'PLS','Color','g','FontSize',fsize) ;
    text(CCAdir(1),CCAdir(2),0,'CCA','Color','b','FontSize',fsize) ;
    ph1 = patch([pl; -pl; -pl; pl; pl], ...
                [pl; pl; -pl; -pl; pl], ...
                [0; 0; 0; 0; 0],[1 1 0], ...
                'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
    ph2 = patch(mpatchc(:,1),mpatchc(:,2),mpatchc(:,3),[0 1 1], ...
               'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
    plot3(mline(1,:),mline(2,:),mline(3,:),'r--','LineWidth',1) ;
    axis equal ;
    axis vis3d ;
    axis off ;
    view(viewang,30) ;
  hold off ;

  %  Create png file
  %
  printSM(['PCAvPLSvCCAp' num2str(iv)],2) ;


end


%{

fighand = figure(2) ;
clf ;

plot3(mdata(1,:),mdata(2,:),mdata(3,:),'k+', ...
          'MarkerSize',msize,'LineWidth',mlw) ;
hold on ;
  plot3([-axl;axl],[0;0],[0;0],'k-','LineWidth',alw) ;
  plot3([0;0],[-axl,axl],[0;0],'k-','LineWidth',alw) ;
  plot3([0;0],[0;0],[-axl,axl],'k-','LineWidth',alw) ;
  text(axl,0,0,'x_1','Color','k','FontSize',fsize) ;
  text(0,axl,0,'x_2','Color','k','FontSize',fsize) ;
  text(0,0,axl,'y','Color','k','FontSize',fsize) ;
  plot3([0;PC1dir(1)],[0;PC1dir(2)],[0;0],'r-','LineWidth',llw) ;
  plot3([0;PLSdir(1)],[0;PLSdir(2)],[0;0],'g-','LineWidth',llw) ;
  plot3([0;CCAdir(1)],[0;CCAdir(2)],[0;0],'b-','LineWidth',llw) ;
  text(1.6 * PC1dir(1),1.6 * PC1dir(2),0, ...
              'PC1','Color','r','FontSize',fsize) ;
  text(1.2 * PLSdir(1),1.2 * PLSdir(2),0, ...
              'PLS','Color','g','FontSize',fsize) ;
  text(CCAdir(1),CCAdir(2),0,'CCA','Color','b','FontSize',fsize) ;
  ph1 = patch([pl; -pl; -pl; pl; pl], ...
              [pl; pl; -pl; -pl; pl], ...
              [0; 0; 0; 0; 0],[1 1 0], ...
              'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
  ph2 = patch(mpatchc(:,1),mpatchc(:,2),mpatchc(:,3),[0 1 1], ...
             'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
  plot3(mline(1,:),mline(2,:),mline(3,:),'r--','LineWidth',1) ;
  axis equal ;
  axis vis3d ;
  axis off ;
  view(viewang2,30) ;
hold off ;

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[10.0, 8.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 9.5, 7.5]) ; 
print('-dpng','OODAfig17p8B.png') ;


figure(3) ;
clf ;

subplot(1,2,1) ;    %  x1-x2 plane
  plot([-axl;axl],[0;0],'k-','LineWidth',alw) ;
    hold on ;
    plot([0;0],[-axl,axl],'k-','LineWidth',alw) ;
    plot([0;PC1dir(1)],[0;PC1dir(2)],'r-','LineWidth',llw) ;
    plot(2 * [-PC1dir(1);PC1dir(1)], ...
         2 * [-PC1dir(2);PC1dir(2)],'r--','LineWidth',1) ;
    plot([0;PLSdir(1)],[0;PLSdir(2)],'g-','LineWidth',llw) ;
    plot([0;CCAdir(1)],[0;CCAdir(2)],'b-','LineWidth',llw) ;
    text(PC1dir(1),PC1dir(2),0,'PC1','Color','r','FontSize',fsize) ;
    text(PLSdir(1),PLSdir(2),0,'PLS','Color','g','FontSize',fsize) ;
    text(CCAdir(1),CCAdir(2),0,'CCA','Color','b','FontSize',fsize) ;
    ph3 = patch([pl; -pl; -pl; pl; pl], ...
                [pl; pl; -pl; -pl; pl],[1 1 0], ...
                'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
    axis([-axl axl -axl axl]) ;
    axis square ;
  hold off ;
  xlabel('x_1','FontSize',fsize)
  ylabel('x_2','FontSize',fsize)

subplot(1,2,2) ;    %  data plane
  plot(-mpc(1,:),mpc(2,:),'k+', ...
            'MarkerSize',msize,'LineWidth',mlw) ;
  hold on ;
    plot([0;-axl],[0;0],'r-','LineWidth',llw) ;
    plot([2 * axl; -2 * axl],[0;0],'r--','LineWidth',1) ;
    text(-1.6 * axl,0,'PC1','Color','r','FontSize',fsize) ;
    ph4 = patch(axl * [s1; -s1; -s1; s1; s1], ...
                axl * [s2; s2; -s2; -s2; s2], ...
                [0 1 1], ...
                'EdgeAlpha',0.2,'FaceAlpha',0.2) ;
    axis(1.05 * axl * [-s1 s1 -s1 s1]) ;
    axis square ;
  hold off ;
  xlabel('PC_1 Score','FontSize',fsize)
  ylabel('PC_2 Score','FontSize',fsize)

%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 4.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
print('-dpng','OODAfig17p8C.png') ;

%}

