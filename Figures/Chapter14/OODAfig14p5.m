disp('Running MATLAB script file OODAfig14p5.m') ;
%
%    Makes Figure 14.5 of the OODA book,
%    HDLSS 2-d simulation toy example
%
%    Copied from OODAbookChpMFigCGeomRepSim.m
%    in:        OODAbook\ChapterM
%


vd = [2 20 200 20000] ;
                %  Vector of Dimensions
nsim = 7 ;

titcellstr = {['High Dim''l Toy Data, d = ' num2str(vd(1))] ... 
              ['Geom''c Simplex Proj''n, d = ' num2str(vd(2))] ... 
              ['n = 3, N(0,I), d = ' num2str(vd(3))] ... 
              [num2str(nsim) ' replications, d = ' num2str(vd(4))]};

figure(1) ;
clf ;

rng(46023475) ;



%  Loop through dimensions
%
iplot = 0 ;
for d = vd ;

  iplot = iplot + 1 ;

  mdataplotx = [] ;
  mdataploty = [] ;
      %  matrices of data to plot

  %  simulation loop
  %
  for isim = 1:nsim ;

    %  Generate data
    %
    mdata = randn(d,3) ;
        %  N(0,1)

    vmean = mean(mdata,2) ;
    mresid = mdata - vec2matSM(vmean,3) ;

    paramstruct = struct('npc',2,...
                         'iscreenwrite',0,...
                         'viout',[0 0 0 0 1]) ;
    outstruct = pcaSM(mresid,paramstruct) ;
    mpc = getfield(outstruct,'mpc') ;
    if size(mpc,1) == 1 ;
      mpc = [mpc; [0 0 0]] ;
    end ;
         %  2x3 matrix "principal components" (scores)
         %  i.e. projections onto 2-d space

    length1 = norm(mpc(:,1)) ;
    length2 = norm(mpc(:,2)) ;
    angbtw = acos((mpc(:,1) / length1)' * (mpc(:,2) / length2)) ;
        %  lengths and angle between vectors in d space

    vmean12 = mean(mpc(:, 1:2),2) ;
        %  mean vector of first 2
    ang12 = atan2(vmean12(2),vmean12(1)) ;
        %  angle of mean12 in this plane
        %    recall atan2 want y as first argument, x as second

    angrot = 3*pi/2 - ang12 - (pi/3 - angbtw/2) ;
        %  angle to rotate, to put mean between 1 and 2 at bottom
        %  with variation in angle added, to move top point off of vertical
    mrot = [[cos(angrot) -sin(angrot)]; [sin(angrot) cos(angrot)]] ;
    mproj = mrot * mpc ;
        %  rotated version of projected data

    mdataplotx = [mdataplotx, mproj(1,:)'] ;
    mdataploty = [mdataploty, mproj(2,:)'] ;

  end ;    % isim loop


  vax2 = axisSM([mdataplotx, mdataploty]) ;
      %  concatenate to get single value for symmetry of axes
  mindat = vax2(1) ;
  maxdat = vax2(2) ;


  %  Make plot
  %
  subplot(2,2,iplot) ;
    plot(mdataplotx,mdataploty,'o') ;
    axis([mindat,maxdat,mindat,maxdat]) ;
    axis square ;
    hold on ;
      plot([mindat; maxdat],[0; 0],'k-') ;
      plot([0; 0],[mindat; maxdat],'k-') ;
      plot([0; sqrt(2*d)/2],[sqrt(6*d)/3; -sqrt(6*d)/6],'k--') ;
      plot([sqrt(2*d)/2; -sqrt(2*d)/2],[-sqrt(6*d)/6; -sqrt(6*d)/6],'k--') ;
      plot([-sqrt(2*d)/2; 0],[-sqrt(6*d)/6; sqrt(6*d)/3],'k--') ;
    hold off ;
    title(['d = ' num2str(d)]) ;

end ;    %  of loop through dimensions


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig14p5.png') ;




