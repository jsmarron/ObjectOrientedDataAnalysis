disp('Running MATLAB script file OODAfig9p12.m') ;
%
%    Makes Figure 9.12 of the OODA book,
%    Illustration of Pinching Effects
%
%    Copied from OODAbookChpHFigGNoPinch.m
%    in:        OODAbook\ChapterH
%

addpath 'subfunctions' -end ;

d = 10000;
t = linspace(0,1,d);

% f1: 2*N(0.5, 0.15^2)
f1Mean = 0.5;
f1Sd = 0.15;
f1 = 2* 1/sqrt(2*pi*f1Sd^2)*exp(-(t-f1Mean).^2/(2*f1Sd^2));
f1 = f1';

% f2: N(0.5, 0.15^2)
f2Mean = 0.5;
f2Sd = 0.15;
f2 = 1/sqrt(2*pi*f2Sd^2)*exp(-(t-f2Mean).^2/(2*f2Sd^2));
f2 = f2';

%%
% for f1
% srvf
srvf1 = fun2srvf(f1,t);
% log derivative
logdf1 = logD(f1,t);

% for f2
% srvf
srvf2 = fun2srvf(f2,t);
% log derivative
logdf2 = logD(f2,t);

nh = 30; % number of transformations

% alpha < 0
epsa = 0.001;
a1 = linspace(0+epsa,0.5-epsa,round(nh/2));

% alpha > 0
a2 = linspace(0.5-epsa,0+epsa, nh-round(nh/2));
a = [a1,a2];
alpha = [-(1-2*a1),1-2*a2];

hIs = zeros(d,nh);

f1s = zeros(d,nh);
f2s = zeros(d,nh);
srvf1s = zeros(d,nh);
srvf2s = zeros(d,nh);
logdf1s = zeros(d,nh);
logdf2s = zeros(d,nh);
fDists = zeros(1,nh);
srvfDists = zeros(1,nh);
logdDists = zeros(1,nh);

for ih = 1:nh;
    
    if alpha(ih)>=0;
        
        % warp h
        aa = a(ih);
        
        hI = interp1([0, aa, 1-aa, 1], [0, 0.5-epsa, 0.5+epsa, 1], t);
        h = interp1([0, 0.5-epsa, 0.5+epsa, 1], [0, aa, 1-aa, 1], t);
        % clf; hold on;
        % plot(t,h); plot(t,hI,'r')
        
        hIs(:,ih) = hI;
        
        % f2oh
        f2h = interp1(t, f2, hI)';
        % clf; hold on;
        % plot(f1,'b'); plot(f2,'r'); plot(f2h,'b')
        
        f1s(:,ih) = f1;
        f2s(:,ih) = f2h;
        
        % srvf
        srvf2h = fun2srvf(f2h,t);
        % clf; hold on;
        % plot(srvf1); plot(srvf2h,'r');
        
        srvf1s(:,ih) = [srvf1; srvf1(end)] ;
        srvf2s(:,ih) = [srvf2h; srvf2h(end)];
        
        % log derivative
        logdf2h = logD(f2h,t);
        % clf; hold on;
        % plot(logdf1); plot(logdf2h,'r');
        
        logdf1s(:,ih) = logdf1;
        logdf2s(:,ih) = logdf2h;
        
        fDists(:,ih) = L2dist(f1,f2h,t);
        srvfDists(:,ih) = L2dist(srvf1,srvf2h,t(1:(end - 1)));
        logdDists(:,ih) = L2dist(logdf1,logdf2h,t);
    end;
    
    
    if alpha(ih)<0;
        % warp h
        aa = a(ih);
        
        h = interp1([0, aa, 1-aa, 1], [0, 0.5-epsa, 0.5+epsa, 1], t);
        hI = interp1([0, 0.5-epsa, 0.5+epsa, 1], [0, aa, 1-aa, 1], t);
        % clf; hold on;
        % plot(t,h); plot(t,hI,'r')
        
        hIs(:,ih) = hI;
        
        % f1oh
        f1h = interp1(t, f1, hI)';
        % clf; hold on;
        % plot(f1,'b'); plot(f2,'r'); plot(f1h,'b')
        
        f1s(:,ih) = f1h;
        f2s(:,ih) = f2;
        
        % srvf
        srvf1h = fun2srvf(f1h,t);
        % clf; hold on;
        % plot(srvf2); plot(srvf1h,'r');
        
        srvf1s(:,ih) = [srvf1h; srvf1h(end)] ;
        srvf2s(:,ih) = [srvf2; srvf2(end)] ;
        
        % log derivative
        logdf1h = logD(f1h,t);
        % clf; hold on;
        % plot(logdf2); plot(logdf1h,'r');
        
        logdf1s(:,ih) = logdf1h;
        logdf2s(:,ih) = logdf2;
        
        
        fDists(:,ih) = L2dist(f2,f1h,t);
        srvfDists(:,ih) = L2dist(srvf2,srvf1h,t(1:(end - 1)));
        logdDists(:,ih) = L2dist(logdf2,logdf1h,t);
    end;
    
end;


%  Find minimizing hs 
%
[temp, ih1] = min(fDists) ; 
[temp, ih2] = min(srvfDists) ; 
[temp, ih3] = min(fDists(17:end)) ; 
ih3 = ih3 + 16 ;


%  Make main output
%
figure(1) ;
clf ;
subplot(3,1,1) ;    %  top panel
  plot(alpha,fDists * 2,'k-','LineWidth',2);
  hold on ;
    plot(alpha,srvfDists,'k-.','LineWidth',2);
    legend('2*L^2(f)','L^2(q)','Location','EastOutside') ;
    vax = axisSM([fDists srvfDists]) ;
    plot([alpha(ih1); alpha(ih1)],[0; vax(2)],'r-','LineWidth',2) ;
    plot([alpha(ih2); alpha(ih2)],[0; vax(2)],'b-','LineWidth',2) ;
    plot([alpha(ih3); alpha(ih3)],[0; vax(2)],'g-','LineWidth',2) ;
    axis([-1 1 0 vax(2)]) ;
  hold off ;

subplot(3,3,4) ;    %  center left
  hI = hIs(:,ih1);
  hold on;
  if alpha(ih)>=0;
      plot(t,hI,'r-','LineWidth',1.5);
      plot([0,1],[0,1],'r--','LineWidth',2)
  else
      plot(t,hI,'r-','LineWidth',1.5);
      plot([0,1],[0,1],'r--','LineWidth',2)
  end;

subplot(3,3,7) ;    %  bottom left
  hold on;
  plot(t,f1s(:,ih1),'r','LineWidth',1.5);
  plot(t,f2s(:,ih1),'r--','LineWidth',2);

subplot(3,3,5) ;    %  center center
  hI = hIs(:,ih2);
  hold on;
  if alpha(ih)>=0;
      plot(t,hI,'b-','LineWidth',1.5);
      plot([0,1],[0,1],'b--','LineWidth',2)
  else
      plot(t,hI,'b--','LineWidth',1.5);
      plot([0,1],[0,1],'b-','LineWidth',2)
  end;

subplot(3,3,8) ;    %  bottom center
  hold on;
  plot(t,f1s(:,ih2),'b','LineWidth',1.5);
  plot(t,f2s(:,ih2),'b--','LineWidth',2);

subplot(3,3,6) ;    %  center right
  hI = hIs(:,ih3);
  hold on;
  if alpha(ih)>=0;
      plot(t,hI,'g--','LineWidth',1.5);
      plot([0,1],[0,1],'g-','LineWidth',2)
  else
      plot(t,hI,'g-','LineWidth',1.5);
      plot([0,1],[0,1],'g--','LineWidth',2)
  end;

subplot(3,3,9) ;    %  bottom right
  hold on;
  plot(t,f1s(:,ih3),'g-','LineWidth',1.5);
  plot(t,f2s(:,ih3),'g--','LineWidth',2);


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 12.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 11.5]) ; 
print('-dpng','OODAfig9p12.png') ;


