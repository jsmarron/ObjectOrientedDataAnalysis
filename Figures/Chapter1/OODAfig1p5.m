disp('Running MATLAB script file OODAfig1p5.m') ;
%
%    Makes graphic similar to Figure 1.5 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigE
%
%    Spanish Male Mortality Data:
%        PC2 Loadings & Scores, Rainbow colors
%
%    Data are in Excel file:
%        ObjectOrientedDataAnalysis\DataSets\SpanishMaleMortalityData.xlsx
%
%    Data are cut off at age 98, for better visual impression
%        paying attention to decadal and half decadal rounding.
%        Also uses improved colors in:  RainbowColorsQY.m
%


%  Load data from Excel file
%
mdata = xlsread('..\..\DataSets\SpanishMaleMortalityData.xlsx','Sheet1','B2:CR112') ;
    %    Rows of mdata are ages 0 - 110
    %    Columns are years 1908 - 2002


%  Cut off ages after 98
%
tmdata = mdata(1:99,:) ;
    %  take first 99 rows


figure(1) ;
clf ;


%  Generate Main Graphics
%
icolor = RainbowColorsQY(size(tmdata,2)) ;

paramstruct = struct('viout',1, ...
                     'vipcplot',2, ...
                     'vicolplot',[1 4], ...
                     'icolor',icolor, ...
                     'dolhtseed',37402983, ...
                     'iscreenwrite',1) ;
curvdatSM(log10(tmdata),paramstruct) ;
vax = axis ;
xlabel('PC2 Scores') ;
set(get(gca,'Title'),'String',[])

subplot(1,2,1) ;
vax = axis ;
xlabel('age') ;
ylabel('log_{10}(mortality)') ;
set(get(gca,'Title'),'String',[])
vchil = get(gca,'Children') ;
set(vchil(1),'String',[]) ;
    %  Last 2 lines turn off sum of squares string
for i = 2:length(vchil) ;
  set(vchil(i),'LineWidth',1) ;
end ;
    %  Change linewidth

%  Further adjust graphics on right
subplot(1,2,2) ;
vchil = get(gca,'Children') ;
vyold = [] ;
for i = 1:(length(vchil)-1) ;
  vyold(i) = get(vchil(i),'YData') ;
end ;
yminold = min(vyold) ;
ymaxold = max(vyold) ;
ydiffold = ymaxold - yminold ;
ymean = (ymaxold + yminold) / 2 ;
yfact = 4 ;
vynew = ymean - yfact * (vyold - ymean) ;
    %  flips upside down and scales by yfact
for i = 1:(length(vchil)-1) ;
  set(vchil(i),'YData',vynew(i)) ;
  set(vchil(i),'LineWidth',1) ;
  set(vchil(i),'MarkerSize',4) ;
end ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig1p5.png') ;



