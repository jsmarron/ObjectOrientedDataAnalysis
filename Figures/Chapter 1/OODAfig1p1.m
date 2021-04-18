disp('Running MATLAB script file OODAfig1p1.m') ;
%
%    Makes Figure 1.1 for Chapter 1 of the OODA book,
%
%    Modified version of:  OODAbookChp1FigA
%
%    Spanish Male log Mortality Data:
%        Raw data curves, Matlab default colors
%
%    Data are in Excel file:
%        ObjectOrientedDataAnalysis\DataSets\SpanishMaleMortalityData.xlsx
%
%    Data are cut off at age 98, for better visual impression
%        paying attention to decadal and half decadal rounding.
%        Also uses improved colors in:  RainbowColorsQY.m
%

mdata = xlsread('..\DataSets\SpanishMaleMortalityData.xlsx','B2') ;

mdata(1:4,1:4)
pauseSM


%{
%
%    Note: to load data, need to first run script:
%           AndresAlonsotvidahombres1908
%   (in directory Research/ComplexPopn/ChemoSpect/TimeSerFDA/Demography/AndresData)
%                 by Andres Alonso, to load data in array:
%                             mrmale
%
%    Rows of that matrix are ages 0 - 110
%    Columns are years 1908 - 2002
%



iout = 5 ;    %  0 - check data read
              %  1 - full color big plots for talk
              %  2 - full color .eps for paper
              %  3 - full color .tif for paper
              %  4 - full color .png for paper
              %  5 - full color .eps, CMYK for paper
%  Note: also tried .jpg (with -djpeg100), but it gave a weird size
%        in the previewed .lyx doucment, hence have dropped it              


%  Check input data is there
%
whostruct = whos('mrmale') ;
if size(whostruct,1) == 0 ;
  disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') ;
  disp('!!!   Error from OODAbookChp1FigA.m               !!!') ;
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
%}

  %  Cut off ages after 98
  %
  tmrmale = mrmale(1:99,:) ;
      %  take first 99 rows

  %  Set initial parameters
  %
  pstr = 'OODAbookChp1FigA' ;

  figure(1) ;
  close 1 ;
  figure(1) ;
      %  these close figure 1, and re-open,
      %  to get rid of above settings
  clf ;

  %  Generate Main Graphics
  %
%{
  paramstruct = struct('viout',1, ...
                       'vipcplot',0, ...
                       'vicolplot',1, ...
                       'icolor',1, ...
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
%}


  subplot(1,2,1) ;
  paramstruct = struct('viout',1, ...
                       'vipcplot',0, ...
                       'vicolplot',1, ...
                       'icolor',1, ...
                       'dolhtseed',37402983, ...
                       'isingleaxis',1, ...
                       'iscreenwrite',1) ;
  curvdatSM(tmrmale,paramstruct) ;
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

%{
    orient portrait ;
    set(gcf,'PaperSize',[6.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-depsc2', [pstr '.eps']) ;
%}
    orient portrait ;
    set(gcf,'PaperSize',[7.0, 3.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 2.5]) ; 
    print('-depsc2', [pstr '.eps']) ;


%{
  elseif iout == 3 ;    %    full color .jpg for paper

    orient portrait ;
    set(gcf,'PaperSize',[6.0, 5.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 5.5, 4.5]) ; 
    print('-djpeg100', [pstr '.jpg']) ;
%}

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
    set(gcf,'PaperPosition',[0.25, 0.25, 6.5, 2.5]) ; 
    print('-depsc2','-cmyk',[pstr 'CMYK.eps']) ;

  end ;


end ;



