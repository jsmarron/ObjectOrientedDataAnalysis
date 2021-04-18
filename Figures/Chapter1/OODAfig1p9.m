disp('Running MATLAB script file OODAfig1p9.m') ;
%
%    Makes Figure 1.9 of the OODA book,
%        Toy example using triangles to illustrate 
%        landmark shape ideas
%
%
%    This came from copying and modifying:    
%        OODAbookChp1FigWToyTris
%    in:        OODAbook\Chapter1
%


%  Set basics
%
left = 0 ;
right = 7 ;
bottom = 0 ;
top = 4 ;
tri1raw = [[0 0]; [0 4]; [2 0]; [0 0]] ;
tri2raw = [[0 0]; [1.5 (3 * sqrt(3) / 2)]; [3 0]; [0 0]] ;
tri3raw = [[0 0]; [2 1]; [4 0]; [0 0]] ;
tri1cent = mean(tri1raw,1) ;
tri2cent = mean(tri2raw,1) ;
tri3cent = mean(tri3raw,1) ;
oascale = 0.2 ;
tri1 = oascale * (tri1raw - (ones(4,1) * tri1cent)) ;
tri2 = oascale * (tri2raw - (ones(4,1) * tri2cent)) ;
tri3 = oascale * (tri3raw - (ones(4,1) * tri3cent)) ;


%  Construct Graphics
%
figure (1) ;
clf ;

plot(tri1(:,1) + 1,tri1(:,2) + 3,'k-') ;
hold on ;
  plot(tri1(:,1) + 2,tri1(:,2) + 3,'k-') ;

  th = -pi / 3 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri1 = tri1 * rotm ;
  plot(rtri1(:,1) + 2,rtri1(:,2) + 2,'k-') ;

  th = pi / 2 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri1 = tri1 * rotm ;
  plot(rtri1(:,1) + 1,rtri1(:,2) + 2,'k-') ;

  plot(1.5 * tri1(:,1) + 1, 1.5 * tri1(:,2) + 0.7,'k-') ;

  th = pi / 3 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri1 = 0.6 * tri1 * rotm ;
  plot(rtri1(:,1) + 2.2,rtri1(:,2) + 0.8,'k-') ;


  plot(tri2(:,1) + 4,tri2(:,2) + 3,'k-') ;

  th = pi / 2 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri2 = tri2 * rotm ;
  plot(rtri2(:,1) + 4.2,rtri2(:,2) + 1.8,'k-') ;

  th = pi / 4 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri2 = 0.6 * tri2 * rotm ;
  plot(rtri2(:,1) + 4.1,rtri2(:,2) + 0.7,'k-') ;


  plot(tri3(:,1) + 6,tri3(:,2) + 3,'k-') ;

  th = pi / 3 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri3 = tri3 * rotm ;
  plot(rtri3(:,1) + 6,rtri3(:,2) + 2,'k-') ;

  th =  -pi / 6 ;
  rotm = [[cos(th) sin(th)]; [-sin(th) cos(th)]] ;
  rtri3 = 1.7 * tri3 * rotm ;
  plot(rtri3(:,1) + 6,rtri3(:,2) + 1,'k-') ;


  plot([3; 3],[bottom; top],'k--','LineWidth',2) ;
  plot([5; 5],[bottom; top],'k-.','LineWidth',2) ;
hold off ;

axis equal ;
axis([left right bottom top]) ;


%  Save .eps file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig1p9.png') ;


