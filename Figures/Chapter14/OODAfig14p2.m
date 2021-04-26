disp('Running MATLAB script file OODAfig14p2.m') ;
%
%    Makes Figure 14.2 of the OODA book,
%    Marcenko Pastur distributions
%
%    Copied from OODAbookChpMFigGMarcPast.m
%    in:        OODAbook\ChapterM
%

figure(1) ;
clf ;

%  Set common quantities
%
nsp = 4 ;
ngrid = 1000 ;
vc = [1; 1/3; 0.1; 0.01] ;
va = (ones(4,1) - sqrt(vc)).^2 ;
vb = (ones(4,1) + sqrt(vc)).^2 ;
diff = 0.1 ;
vmin = va - diff ;
vmax = vb + diff ;
mcol = [[0 0 0]; ...
        [1 0 0]; ...
        [0 0 1]; ...
        [0 1 0]] ;

mgride = [] ;
hold on ;
for ic = 1:4 ;
  c = vc(ic) ;
  a = va(ic) ;
  b = vb(ic) ;
  vgrid = linspace(max(0,vmin(ic)),vmax(ic),ngrid)' ;
  vf = zeros(ngrid,1) ;
  flagn0 = (a < vgrid) & (vgrid < b) ;
      %  one at locations where MP is positive
  vf(flagn0) = sqrt((b - vgrid(flagn0)) .* (vgrid(flagn0) - a)) ./ ...
                               (2 * pi * c * vgrid(flagn0)) ;
  flaggt0 = vgrid > 0 ;
      %  one on positive x-axis
  vgrid = vgrid(flaggt0) ;
  vf = vf(flaggt0) ;
  plot(vgrid,vf,'-','LineWidth',1.5,'Color',mcol(ic,:)) ;
  mgride = [mgride [vgrid(1); vgrid(end)]] ;
  if ic == 4 ;
    fmax = max(vf) ;
  end ;
end ;
vaxx = axisSM(mgride) ;
vaxy = [-0.05 1.05] * fmax ;
axis([vaxx vaxy]) ;
gl = 0.1 ;
plot([vaxx(1); vaxx(2)],[0; 0],':','Color',[gl gl gl]) ;
plot([0; 0],[vaxy(1); vaxy(2)],':','Color',[gl gl gl]) ;
plot([1; 1],[vaxy(1); vaxy(2)],'--','Color',[gl gl gl]) ;
xlabel('eigenvalue') ;
ylabel('density') ;



%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 7.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 6.5]) ; 
print('-dpng','OODAfig14p2.png') ;




