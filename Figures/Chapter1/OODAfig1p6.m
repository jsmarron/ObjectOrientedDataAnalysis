disp('Running MATLAB script file OODAfig1p6.m') ;
%
%    Makes graphic similar to Figure 1.6 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigF
%
%    Spanish Male Mortality Data:
%        PC1-2 Scatterplot, Rainbow colors
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

n = size(tmdata,2) ;
paramstruct = struct('npc',2, ...
                     'viout',[0 1], ...
                     'iscreenwrite',1) ;
outstruct = pcaSM(log10(tmdata),paramstruct) ;
meigvec = getfield(outstruct,'meigvec') ;

idataconn = [(1:(n-1))' (2:n)'] ;
idataconncolor = RainbowColorsQY(size(tmdata,2)-1) ;
paramstruct = struct('icolor',icolor, ...
                     'idataconn',idataconn, ...
                     'idataconncolor',idataconncolor, ...
                     'xlabelstr','PC1 Scores', ...
                     'ylabelstr','PC2 Scores', ...
                     'iscreenwrite',1) ;
projplot2SM(log10(tmdata) - mean(log10(tmdata),2) * ones(1,n),meigvec,paramstruct) ;
vax = axis ;

%  Change Line Widths
vchil = get(gca,'Children') ;
for i = 1:length(vchil) ;
  set(vchil(i),'LineWidth',1) ;
end ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig1p6.png') ;



