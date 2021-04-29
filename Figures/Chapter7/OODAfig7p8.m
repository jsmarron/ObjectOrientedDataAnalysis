disp('Running MATLAB script file OODAfig7p8.m') ;
%
%    Makes Figure 7.8 of the OODA book,
%    Illustrates Driver of Horseshoe Effect
%
%    Copied from OODAbookChpEFigIHorseshoe.m
%    in:        OODAbook\ChapterE
%


figure(1) ;
clf ;

plot([0; 0.4; 1],[0.4; 0; 0.6],'k--','LineWidth',3) ;
hold on ;
  plot([0; 0.8; 1],[0.8; 0; 0.2],'k-.','LineWidth',3) ;
  patch([0; 0.4; 0.6; 0; 0],[0.4; 0; 0.2; 0.8; 0.4],'c','FaceAlpha',0.5) ;
  ph = patch([0.8; 1; 1; 0.6; 0.8],[0; 0.2; 0.6; 0.2; 0],'c','FaceAlpha',0.5) ;
  plot([0.4; 0.8; 0.8; 0.4; 0.4],[0; 0; 0.4; 0.4; 0],'k-','LineWidth',1) ;
  text(0.58,0.04,'\delta','Fontsize',18) ;
  text(0.01,0.58,'\delta','Fontsize',18) ;
hold off ;

axis([0 1 0 1]) ;
axis square ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[6.0, 6.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 5.5]) ; 
print('-dpng','OODAfig7p8.png') ;



