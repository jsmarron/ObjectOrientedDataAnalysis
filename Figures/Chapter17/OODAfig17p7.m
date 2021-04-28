disp('Running MATLAB script file OODAfig17p7.m') ;
%
%    Makes graphic similar to Figure 17.7 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChpPFigCMortLoadCorr.m
%
%    Data are in Excel file:
%        ObjectOrientedDataAnalysis\DataSets\SpanishMaleMortalityData.xlsx
%
%    Data are cut off at age 98, for better visual impression
%        paying attention to decadal and half decadal rounding.
%


%  Load data from Excel file
%
mdata = xlsread('..\..\DataSets\SpanishMaleMortalityData.xlsx','Sheet1','B2:CR112') ;
    %    Rows of mdata are ages 0 - 110
    %    Columns are years 1908 - 2002


figure(1) ;
clf ;


%  Cut off ages after 98
%
mdata = mdata(1:99,:) ;
    %  take first 99 rows

mdata = log10(mdata) ;

d = size(mdata,1) ;
n = size(mdata,2) ;

varnamecellstr = {} ;
for iy = 1908:2006 ;
  varnamecellstr = cat(1,varnamecellstr,{num2str(iy)}) ;
end ;


%  Do Common PCA
%
paramstruct = struct('npc',3, ...
                     'iscreenwrite',1, ...
                     'viout',[0 1]) ;
outstruct = pcaSM(mdata,paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;
    %  d x 3 matrix of loadings


disp('Making Loadings Scatterplot Matrix') ;
disp(' ') ;
figure(1) ;
clf ;
icolor = HeatColorsSM(d) ;
idataconn = [(1:(d - 1))' (2:d)'] ;
idataconncolor = HeatColorsSM(d - 1) ;
labelcellstr = {{'Loadings 1'; 'Loadings 2'; 'Loadings 3'}} ;
paramstruct = struct('npcadiradd',0, ...
                     'irecenter',0, ...
                     'icolor',icolor, ...
                     'markerstr','*', ...
                     'idataconn',idataconn, ...
                     'idataconncolor',idataconncolor, ...
                     'labelcellstr',labelcellstr, ...
                     'iscreenwrite',1) ;
scatplotSM(meigvec(:,1:3)',eye(3),paramstruct) ;
subplot(3,3,2) ;
  vax = axis ;
  tx = vax(1) + 0.4 * (vax(2) - vax(1)) ;
  ty = vax(3) + 0.9 * (vax(4) - vax(3)) ;
  text(tx,ty,['\rho = ' num2str(corr(meigvec(:,1),meigvec(:,2)),2)]) ;
subplot(3,3,3) ;
  vax = axis ;
  tx = vax(1) + 0.4 * (vax(2) - vax(1)) ;
  ty = vax(3) + 0.9 * (vax(4) - vax(3)) ;
  text(tx,ty,['\rho = ' num2str(corr(meigvec(:,1),meigvec(:,3)),2)]) ;
subplot(3,3,6) ;
  vax = axis ;
  tx = vax(1) + 0.4 * (vax(2) - vax(1)) ;
  ty = vax(3) + 0.9 * (vax(4) - vax(3)) ;
  text(tx,ty,['\rho = ' num2str(corr(meigvec(:,2),meigvec(:,3)),2)]) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig17p7.png') ;




