disp('Running MATLAB script file OODAfig1p1.m') ;
%
%    Makes graphic similar to Figure 1.1 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigA
%
%    Spanish Male Mortality Data:
%        Raw data curves, Matlab default colors
%
%    Data are in Excel file:
%        ObjectOrientedDataAnalysis\DataSets\SpanishMaleMortalityData.xlsx
%
%    Data are cut off at age 98, for better visual impression
%        paying attention to decadal and half decadal rounding.
%        Also uses improved colors in:  RainbowColorsQY.m
%

iout = 1 ;    %  0 - check data read
              %  1 - Make .png file


%  Load data from Excel file
%
mdata = xlsread('..\..\DataSets\SpanishMaleMortalityData.xlsx','Sheet1','B2:CR112') ;
    %    Rows of mdata are ages 0 - 110
    %    Columns are years 1908 - 2002


if iout == 0 ;

  disp('Check size of input matrix is:  111 x 95') ;
  size(mdata)

  disp('Check for 1908, age = 0, mortality = 0.16776') ;
  mdata(1,1)

  disp('Check for 2002, age = 0, mortality = 0.00463') ;
  mdata(1,end)

  disp('Check for 1908, age = 110, mortality = 1.00000') ;
  mdata(end,1)

  disp('Check for 2002, age = 110, mortality = 1.00000') ;
  mdata(end,end)

  disp('Check for 1908, age = 109, mortality = 0.32863') ;
  mdata(end-1,1)

  disp('Check for 2002, age = 109, mortality = 0.50508') ;
  mdata(end-1,end)


else ;    %  Make main graphic

  %  Cut off ages after 98
  %
  tmdata = mdata(1:99,:) ;
      %  take first 99 rows

  figure(1) ;
  clf ;

  subplot(1,2,1) ;
    paramstruct = struct('viout',1, ...
                         'vipcplot',0, ...
                         'vicolplot',1, ...
                         'icolor',1, ...
                         'dolhtseed',37402983, ...
                         'isingleaxis',1, ...
                         'iscreenwrite',1) ;
    curvdatSM(tmdata,paramstruct) ;
    vax = axis ;
    xlabel('age') ;
    ylabel('mortality') ;
    set(get(gca,'Title'),'String',[])

    %  Change Line Widths
    vchil = get(gca,'Children') ;
    for i = 1:length(vchil) ;
      set(vchil(i),'LineWidth',1) ;
    end ;

  subplot(1,2,2) ;
    paramstruct = struct('viout',1, ...
                         'vipcplot',0, ...
                         'vicolplot',1, ...
                         'icolor',1, ...
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

  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 4.5]) ; 
  print('-dpng','OODAfig1p1.png') ;


end ;


