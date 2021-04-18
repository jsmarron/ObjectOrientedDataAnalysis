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
  set(gcf,'PaperSize',[6.0, 5.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
print('-dpng','OODAfig1p2.png') ;




%{
iout = 6 ;    %  0 - check data read
              %  1 - full color big plots for talk
              %  2 - full color .eps for paper
              %  3 - full color .tif for paper
              %  4 - full color .png for paper
              %  5 - full color .eps, CMYK for paper
              %  6 - full color .eps, CMYK for paper, with color bar


%  Check input data is there
%
whostruct = whos('mrmale') ;
if size(whostruct,1) == 0 ;
  disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') ;
  disp('!!!   Error from OODAbookChp1FigB.m               !!!') ;
  disp('!!!   Must run Andres Alonso''s Script             !!!') ;
  disp('!!!   file:   AndresAlonsotvidahombres1908.m      !!!') ;
  disp('!!!    in ComplexPopn\ChemoSpect\TimeSerFDA\Demography\AndresData ') ;
  disp('!!!   to load data, before calling this script    !!!') ;
  disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') ;
  return ;
end ;


if iout == 0 ;

  disp('Check size of input matrix is:  111 x 95') ;
  size(mrmale)

  disp('Check for 1908, age = 0, mortality = 0.16776') ;
  mrmale(1,1)

  disp('Check for 2002, age = 0, mortality = 0.00463') ;
  mrmale(1,end)

  disp('Check for 1908, age = 110, mortality = 1.00000') ;
  mrmale(end,1)

  disp('Check for 2002, age = 110, mortality = 1.00000') ;
  mrmale(end,end)


else ;

  %  Cut off ages after 98
  %
  tmrmale = mrmale(1:99,:) ;
      %  take first 99 rows

  %  Set initial parameters
  %
  pstr = 'OODAbookChp1FigB' ;

  figure(1) ;
  close 1 ;
  figure(1) ;
      %  these close figure 1, and re-open,
      %  to get rid of above settings
  clf ;

  %  Generate Main Graphics
  %
  icolor = RainbowColorsQY(size(tmrmale,2)) ;
  paramstruct = struct('viout',1, ...
                       'vipcplot',0, ...
                       'vicolplot',1, ...
                       'icolor',icolor, ...
                       'dolhtseed',37402983, ...
                       'isingleaxis',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(log10(tmrmale),paramstruct) ;
  vax = axis ;
  xlabel('age') ;
  ylabel('log_{10}(mortality)') ;
  set(get(gca,'Title'),'String',[])

  %  Change Line Widths
  vchil = get(gca,'Children') ;
  for i = 1:length(vchil) ;
    set(vchil(i),'LineWidth',1) ;
  end ;

  if iout == 1 ;    %    full color big plot for talk

    xlabel('age','FontSize',15) ;
    ylabel('log_{10}(mortality)','FontSize',15) ;
    title('Spanish Mortality Data, 1908-2002','FontSize',18) ;
    orient landscape ;
    print('-dpsc2', [pstr 'big.ps']) ;

  elseif iout == 2 ;    %    full color .eps for paper

    orient portrait ;
    set(gcf,'PaperSize',[6.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-depsc2', [pstr '.eps']) ;

  elseif iout == 3 ;    %    full color .tif for paper

    orient portrait ;
    set(gcf,'PaperSize',[6.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-dtiff', [pstr '.tif']) ;

  elseif iout == 4 ;    %    full color .png for paper

    orient portrait ;
    set(gcf,'PaperSize',[6.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-dpng', [pstr '.png']) ;

  elseif iout == 5 ;    %    full color .eps. CMYK for paper

    orient portrait ;
    set(gcf,'PaperSize',[7.0, 3.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-depsc2','-cmyk',[pstr 'CMYK.eps']) ;

  elseif iout == 6 ;    %    full color .eps. CMYK for paper, with color bar

    colorbar ;
    set(gcf,'Colormap',icolor) ;
    vcf = get(gcf,'Children') ;
    YTL = strvcat('1917','1927','1937','1947','1957','1967','1977','1987','1997') ;
    set(vcf(1),'YTickLabel',YTL) ;

    orient portrait ;
    set(gcf,'PaperSize',[6.0, 4.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 3.5]) ; 
    print('-depsc2','-cmyk',[pstr '2CMYK.eps']) ;

  end ;


end ;
%}


