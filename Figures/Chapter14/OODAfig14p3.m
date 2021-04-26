disp('Running MATLAB script file OODAfig14p3.m') ;
%
%    Makes Figure 14.3 of the OODA book,
%    Marcenko Pastur distributions, based on non-Gaussians
%
%    Copied from OODAbookChpMFigFDiffDistMP.m
%    in:        OODAbook\ChapterM
%

figure(1) ;
clf ;

%  Set common quantities
%
d = 100 ;
n = 1000 ;
seed = 56083476 ;
seed = 34985732 ;
rng(seed) ;
mcol = [[0 0 0]; ...
        [0 0.9 0]; ...
        [0.8 0 0.8]] ;
fs = 10 ;    %  Font Size for Axis Labels
vms = [6 6 5] ;    %  Marker Size
lw = 1 ;    %  Line Width
vind = (1:d)' ;


%  Generate Gaussian Eigenvalues
%
mdatg = randn(d,n) ;
    %  N(0,1)
veigg = eig(mdatg * mdatg') ;
veigg = flipud(veigg / n) ;

%  Generate Binary Eigenvalues
%
mdatb = binornd(1,0.5,d,n) ;
    %  Bernoulli(0.5)
mdatb = 2 * mdatb - ones(d,n) ;
    %  Make mean 0, variance 1
veigb = eig(mdatb * mdatb') ;
veigb = flipud(veigb / n) ;

%  Generate Exponential Eigenvalues
%
mdate = exprnd(1,d,n) ;
    %  Exponential with rate parameter 1, has mean 1 and var 1
mdate = mdate - ones(d,n) ;
    %  Make mean 0, variance 1
veige = eig(mdate * mdate') ;
veige = flipud(veige / n) ;


%  Make graphics
%
plot(vind,veigg,'o','Color',mcol(1,:),'MarkerSize',vms(1),'LineWidth',lw) ;
hold on ;
  plot(vind,veige,'+','Color',mcol(3,:),'MarkerSize',vms(2),'LineWidth',lw) ;
  plot(vind,veigb,'x','Color',mcol(2,:),'MarkerSize',vms(3),'LineWidth',lw) ;
  xlabel('index j','FontSize',fs) ;
  ylabel('eigenvalue','FontSize',fs) ;
  plot([0; (d + 1)],[1; 1],'k--') ;
hold off ;
axis([0 (d+1) 0 2]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 7.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
print('-dpng','OODAfig14p3.png') ;




