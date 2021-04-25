disp('Running MATLAB script file OODAfig11p11.m') ;
%
%    Makes Figure 11.11 of the OODA book,
%    Illustrates SVM
%
%    Copied from OODAbookChpJFigGSVMPIntro.m
%    in:        OODAbook\ChapterJ
%
%    This uses the Matlab t-SNE software of Laurens van der Maaten, 2010
%    Must be in the Matlab path


%  Start graphics
%
figure(1) ;
clf ;


%  Generate Data
%
seed = 70937425 ;
randn('seed',seed) ;
n = 15 ;

data1 = randn(1,n) ;
data1 = [1.5 + data1 ; (0 + data1 + 0.6 * randn(1,n))] ;
data2 = randn(1,n) ;
data2 = [-1.5 + data2 ; (0 + data2 + 0.6 * randn(1,n))] ;

bottom = min(min([data1 data2])) ;
top = max(max([data1 data2])) ;
range = top - bottom ;
bottom = bottom - 0.02 * range ;
top = top + 0.02 * range ;
left = bottom - 0.15 * range ;
right = top + 0.15 * range ;


%  Compute SVM direction vector etc. for plotting
%
[dirvec, beta] = SVM1SM(data1,data2) ;
w = dirvec ;

mtrainall = [data1 data2]' ;

vcenter = beta * w ;
hpdir = [w(2); -w(1)] ;
    %  vector in direction of hyperplane

vproj1nv = data1' * w ;
vproj2nv = data2' * w ;
      %  column vector of projections of data onto normal vector

marg = min(abs([vproj1nv; vproj2nv])) ;
flag = abs(marg - abs([vproj1nv; vproj2nv])) < 10^(-2) ;


%  Make right subplot
%
subplot(1,2,1) ;
plot(data1(1,:),data1(2,:),'r+', ...
     data2(1,:),data2(2,:),'bo', ...
         'MarkerSize',6,'LineWidth',1.5) ;
  axis equal ;
  axis([left,right,bottom,top]) ;
  axis off ;
  hold on ;
    plot([[0;0], [bottom;top]],[[left;right], [0;0]],'k-') ;
    plot([4.2; -5.5],[5.5; -8],'--','LineWidth',2,'Color',[0 0.4 0]) ;
    plot([5; -6],[5; -6],'--','LineWidth',2,'Color',[0.6 0.6 0]) ;
    plot([4; -5.5],[5.4 -6.6],'--','LineWidth',2,'Color',[0 0.7 0.7]) ;
  hold off ;



%  Make left subplot
%
subplot(1,2,2) ;
plot(data1(1,:),data1(2,:),'r+', ...
     data2(1,:),data2(2,:),'bo', ...
         'MarkerSize',6,'LineWidth',1.5) ;
  axis equal ;
  axis([left,right,bottom,top]) ;
  axis off ;
  hold on ;
    plot([[0;0], [bottom;top]],[[left;right], [0;0]],'k-') ;
    plot([vcenter(1); vcenter(1) + 3 * w(1)], ...
         [vcenter(2); vcenter(2) + 3 * w(2)], ...
             'm-','LineWidth',3) ;
    plot([(vcenter(1) - 6 * hpdir(1)); (vcenter(1) + 6 * hpdir(1))], ...
         [(vcenter(2) - 6 * hpdir(2)); (vcenter(2) + 6 * hpdir(2))], ...
             'm--','LineWidth',3) ;

    for i = 1:n ;
      vproj1hp = vcenter + (data1(:,i)' * hpdir) * hpdir ;
      vproj2hp = vcenter + (data2(:,i)' * hpdir) * hpdir ;
          %  projection of data point onto separating hyperplane
      if vproj1nv(i) >= beta ;    %  then data1 is on correct side
        plot([data1(1,i); vproj1hp(1,1)], ...
             [data1(2,i); vproj1hp(2,1)],'m-') ;
      else ;    %  then data1 is on wrong side
        plot([data1(1,i); vproj1hp(1,1)], ...
             [data1(2,i); vproj1hp(2,1)],'g--','LineWidth',3) ;
      end ;
      if vproj2nv(i) <= beta ;    %  then data2 is on correct side
        plot([data2(1,i); vproj2hp(1,1)], ...
             [data2(2,i); vproj2hp(2,1)],'m-') ;
      else ;    %  then data1 is on wrong side
        plot([data2(1,i); vproj2hp(1,1)], ...
             [data2(2,i); vproj2hp(2,1)],'g--','LineWidth',3) ;
      end ;
    end ;

    plot(mtrainall(flag,1),mtrainall(flag,2), ...
             'ks','MarkerSize',12,'LineWidth',2) ;
    plot([(vcenter(1) + marg * w(1) - 6 * hpdir(1)); ...
              (vcenter(1) + marg * w(1) + 6 * hpdir(1))], ...
         [(vcenter(2) + marg * w(2) - 6 * hpdir(2)); ...
              (vcenter(2) + marg * w(2) + 6 * hpdir(2))], ...
             'k:','LineWidth',2) ;
    plot([(vcenter(1) - marg * w(1) - 6 * hpdir(1)); ...
              (vcenter(1) - marg * w(1) + 6 * hpdir(1))], ...
         [(vcenter(2) - marg * w(2) - 6 * hpdir(2)); ...
              (vcenter(2) - marg * w(2) + 6 * hpdir(2))], ...
             'k:','LineWidth',2) ;
  hold off ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig11p11.png') ;



