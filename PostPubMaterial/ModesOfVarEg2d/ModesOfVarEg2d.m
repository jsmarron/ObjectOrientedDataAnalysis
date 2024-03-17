disp('Running MATLAB script file ModesOfVarEg2d.m') ;
%
%    Makes 2d toy example demonstrating modes of variation
%    Raw Data
%    PCA Continuous Mode, Projected Mode, Equally Spaced Mode 
%    Mean Diff Continuous Mode, Projected Mode, Equally Spaced Mode 
%    DWD Continuous Mode, Projected Mode, Equally Spaced Mode 
%


%  Generate toy data
%
rng(64198246) ;
rng(64194709) ;
mu1 = [0.55; 0.4] ;
mu2 = [0.45; 0.6] ;
sig = [[0.03 ; 0.0295],[0.0295 ; 0.03]] ;
sigr = sqrtm(sig) ;
n1 = 10 ;
n2 = 10 ;
mdata1 = mu1 * ones(1,n1) + sigr * randn(2,n1) ;
mdata1 = [mdata1 [0.23; 0.1] [0.24; 0.07]] ;
mdata2 = mu2 * ones(1,n2) + sigr * randn(2,n2) ;
mdata2 = [mdata2 [0.70; 0.95] [0.72; 0.94]] ;


%  Make Raw Data Plot
%
figure(1) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dRawData.png') ;


%  Compute PC1 Quantities
%
paramstruct = struct('npc',1, ...
                     'viout',[0 1 1 0 1],...
                     'iscreenwrite',1) ;
outstruct = pcaSM([mdata1 mdata2],paramstruct) ;
  meigvec = getfield(outstruct,'meigvec') ;
  vmean = getfield(outstruct,'vmean') ;
  mpc = getfield(outstruct,'mpc') ;
movcontends = [[vmean + meigvec] [vmean - meigvec]] ;
movproj = vmean + meigvec * mpc ;
esgrid = linspace(-1,1,21) ;
moves = vmean + meigvec * esgrid ;


%  Plot PC1 Mode - Continuous
%
figure(2) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',4) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'PC1 Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Continuous','FontSize',12) ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dPC1-Cont.png') ;


%  Plot PC1 Mode - Projected
%
figure(3) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(movproj(1,1:(n1 + 2)),movproj(2,1:(n1 + 2)), ...
                       'b+','LineWidth',2,'MarkerSize',10) ;
    plot(movproj(1,(n1 + 3):(n1 + n2 + 4)), ...
                       movproj(2,(n1 + 3):(n1 + n2 + 4)), ...
                       'bx','LineWidth',2,'MarkerSize',10) ;
    plot([mdata1(1,:); movproj(1,1:(n1 + 2))], ...
         [mdata1(2,:); movproj(2,1:(n1 + 2))],'b-','LineWidth',1) ;
    plot([mdata2(1,:); movproj(1,(n1 + 3):(n1 + n2 + 4))], ...
         [mdata2(2,:); movproj(2,(n1 + 3):(n1 + n2 + 4))],'b-','LineWidth',1) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'PC1 Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Projected','FontSize',12,'Color','b') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dPC1-Proj.png') ;


%  Plot PC1 Mode - Equally Spaced
%
figure(4) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(moves(1,:),moves(2,:),'go','LineWidth',2,'MarkerSize',10) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'PC1 Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Equally Spaced','FontSize',12,'Color','g') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dPC1-EqSp.png') ;


%  Compute MD Quantities
%
vmean1 = mean(mdata1,2) ;
vmean2 = mean(mdata2,2) ;
vmean = mean([vmean1 vmean2],2) ;
vmd = vmean1 - vmean2 ;
vmd = vmd / norm(vmd) ;
movcontends = [[vmean + vmd] [vmean - vmd]] ;
vcoeff1 = vmd' * (mdata1 - vmean * ones(1,n1 + 2)) ;
movproj1 = vmean + vmd * vcoeff1 ;
vcoeff2 = vmd' * (mdata2 - vmean * ones(1,n2 + 2)) ;
movproj2 = vmean + vmd * vcoeff2 ;
esgrid = linspace(-1,1,21) ;
moves = vmean + vmd * esgrid ;


%  Plot MD Mode - Continuous
%
figure(5) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(vmean1(1),vmean1(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(vmean2(1),vmean2(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',4) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'MD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Continuous','FontSize',12) ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dMD-Cont.png') ;


%  Plot MD Mode - Projected
%
figure(6) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(vmean1(1),vmean1(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(vmean2(1),vmean2(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(movproj1(1,:),movproj1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
    plot(movproj2(1,:),movproj2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot([mdata1(1,:); movproj1(1,:)], ...
         [mdata1(2,:); movproj1(2,:)],'b-','LineWidth',1) ;
    plot([mdata2(1,:); movproj2(1,:)], ...
         [mdata2(2,:); movproj2(2,:)],'b-','LineWidth',1) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'MD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Projected','FontSize',12,'Color','b') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dMD-Proj.png') ;


%  Plot MD Mode - Equally Spaced
%
figure(7) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(vmean1(1),vmean1(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(vmean2(1),vmean2(2),'bd','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(moves(1,:),moves(2,:),'go','LineWidth',2,'MarkerSize',10) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'MD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Equally Spaced','FontSize',12,'Color','g') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dMD-EqSp.png') ;


%  Compute DWD Quantities
%
vmean = mean([mdata1 mdata2],2) ;
vdwd = DWD2XQ(mdata1,mdata2) ;
movcontends = [[vmean + vdwd] [vmean - vdwd]] ;
vcoeff1 = vdwd' * (mdata1 - vmean * ones(1,n1 + 2)) ;
movproj1 = vmean + vdwd * vcoeff1 ;
vcoeff2 = vdwd' * (mdata2 - vmean * ones(1,n2 + 2)) ;
movproj2 = vmean + vdwd * vcoeff2 ;
esgrid = linspace(-1,1,21) ;
moves = vmean + vdwd * esgrid ;


%  Plot DWD Mode - Continuous
%
figure(8) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',4) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'DWD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Continuous','FontSize',12) ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dDWD-Cont.png') ;


%  Plot DWD Mode - Projected
%
figure(9) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(movproj1(1,:),movproj1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
    plot(movproj2(1,:),movproj2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot([mdata1(1,:); movproj1(1,:)], ...
         [mdata1(2,:); movproj1(2,:)],'b-','LineWidth',1) ;
    plot([mdata2(1,:); movproj2(1,:)], ...
         [mdata2(2,:); movproj2(2,:)],'b-','LineWidth',1) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'DWD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Projected','FontSize',12,'Color','b') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dDWD-Proj.png') ;


%  Plot DWD Mode - Equally Spaced
%
figure(10) ;
clf ;
plot(mdata1(1,:),mdata1(2,:),'b+','LineWidth',2,'MarkerSize',10) ;
  hold on ;
    plot(mdata2(1,:),mdata2(2,:),'bx','LineWidth',2,'MarkerSize',10) ;
    plot(vmean(1),vmean(2),'ks','LineWidth',2,'MarkerSize',15) ;
    plot(movcontends(1,:),movcontends(2,:),'k-','LineWidth',1) ;
    plot(moves(1,:),moves(2,:),'go','LineWidth',2,'MarkerSize',10) ;
    title('Toy 2-d Data Set','FontSize',15,'Color','b') ;
    text(0.1,0.9,'DWD Mode of Variation','FontSize',12) ;
    text(0.1,0.8,'Equally Spaced','FontSize',12,'Color','g') ;
  hold off ;
axis([0 1 0 1]) ;
axis square ;
print('-dpng','MOV2dDWD-EqSp.png') ;


