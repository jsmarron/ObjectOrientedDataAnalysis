disp('Running MATLAB script file OODAfig1p3.m') ;
%
%    Makes graphic similar to Figure 1.3 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigC
%
%    Spanish Male Mortality Data:
%        Mean & Mean Residuals, Rainbow colors
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
                     'vicolplot',[2 3], ...
                     'icolor',icolor, ...
                     'dolhtseed',37402983, ...
                     'iscreenwrite',1) ;
curvdatSM(log10(tmdata),paramstruct) ;
vax = axis ;

subplot(1,2,1) ;
  vax = axis ;
  xlabel('age') ;
  ylabel('log_{10}(mortality)') ;
  set(get(gca,'Title'),'String',[]) ;
  vchil = get(gca,'Children') ;
  set(vchil(1),'String',[]) ;
      %  Last 2 lines turn off sum of squares string
    set(vchil(2),'LineWidth',1) ;
      %  Change linewidth

subplot(1,2,2) ;
  vax = axis ;
  xlabel('age') ;
  ylabel('log_{10}(mortality)') ;
  set(get(gca,'Title'),'String',[]) ;
  vchil = get(gca,'Children') ;
  set(vchil(1),'String',[]) ;
      %  Last 2 lines turn off sum of squares string
  for i = 2:length(vchil) ;
    set(vchil(i),'LineWidth',1) ;
  end ;
      %  Change linewidth


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
print('-dpng','OODAfig1p3.png') ;



