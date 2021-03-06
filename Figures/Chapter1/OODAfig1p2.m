disp('Running MATLAB script file OODAfig1p2.m') ;
%
%    Makes graphic similar to Figure 1.1 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigB
%
%    Spanish Male Mortality Data:
%        Raw data curves, Rainbow colors
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
                     'vipcplot',0, ...
                     'vicolplot',1, ...
                     'icolor',icolor, ...
                     'dolhtseed',37402983, ...
                     'isingleaxis',1, ...
                     'iscreenwrite',1) ;
curvdatSM(log10(tmdata),paramstruct) ;
vax = axis ;
xlabel('age') ;
ylabel('log_{10}(mortality)') ;
set(get(gca,'Title'),'String',[])

%  Change Line Widths
vchil = get(gca,'Children') ;
for i = 1:length(vchil) ;
  set(vchil(i),'LineWidth',1) ;
end ;


%  Add Colorbar
%
colorbar ;
set(gcf,'Colormap',icolor) ;
vcf = get(gcf,'Children') ;
YTL = strvcat('1917','1927','1937','1947','1957','1967','1977','1987','1997') ;
set(vcf(1),'YTickLabel',YTL) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[7.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 4.5]) ; 
print('-dpng','OODAfig1p2.png') ;




