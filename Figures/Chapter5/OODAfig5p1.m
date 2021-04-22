disp('Running MATLAB script file OODAfig5p1.m') ;
%
%    Makes graphic similar to Figure 5.1 for Chapter 5 of the OODA book,
%
%    Modified version of:  OODAbookChpBFigE.m
%    in:        OODAbook\ChapterB
%
%    Spanish Male Mortality Data:
%        Marginal distribution plot, Raw data
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
d = size(tmdata,1) ;
n = size(tmdata,2) ;


figure(1) ;
clf ;

%  Generate Main Graphics
%
varnamecellstr = {} ;
for i = 1:d ;
  varnamecellstr = cat(1,varnamecellstr,{[num2str(i-1) ' Years Old']}) ;
end ;
varnamecellstr = {varnamecellstr} ;
icolor = RainbowColorsQY(size(tmdata,2)) ;
paramstruct = struct('istat',1, ...
                     'varnamecellstr',varnamecellstr, ...
                     'nplot',9, ...
                     'icolor',flipud(icolor), ...
                     'datovlaymax',0.7, ...
                     'datovlaymin',0.3) ;
MargDistPlotSM(fliplr(tmdata),paramstruct) ;
    %  fliprl inverts order of columns, to put earlier cases at top


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig5p1.png') ;



