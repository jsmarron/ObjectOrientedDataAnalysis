disp('Running MATLAB script file OODAfig5p8.m') ;
%
%    Makes graphic similar to Figure 5.8 for Chapter 5 of the OODA book,
%
%    Modified version of:  OODAbookChpDFigF.m
%    in:        OODAbook\ChapterD
%
%    Drug Discovery Data:
%        Cleaned data, Marginal Distribution Plot, S.D.
%
%    Data are in Excel file:
%        ObjectOrientedDataAnalysis\DataSets\DrugDiscoveryData.xlsx
%
%

%  Load data from Excel file
%
[NUM,TXT] = xlsread('..\..\DataSets\DrugDiscoveryData.xlsx') ;

n = size(NUM,1)
d = size(NUM,2) - 3 
    %  Since 1st column is response, 2nd & 3rd are Number
vresp = NUM(1:end,1)' ;
mdata = NUM(1:end,4:end)' ;
    %  Transpose to turn data objects into columns
varnames = TXT(4:end) ;


%  Rearrange varnamecellstr
varnamecellstr = {} ;
for j = 1:d ;
  varnamecellstr = cat(1,varnamecellstr,{varnames{j}}) ;
end ;


%  Kick out 0 Sd vars, and those with -999s
%
vsd = std(mdata,0,2) ;
flag0 = (vsd == 0) ;
disp(['Found ' num2str(sum(flag0)) ' 0 SD variables']) ;
flagmiss = logical(max(mdata == -999,[],2)) ;
disp(['Found ' num2str(sum(flagmiss)) ' variables coded as -999']) ;
flagdel = flag0 | flagmiss ;
d = d - sum(flagdel) ;
disp([num2str(sum(flagdel)) ' 0 SD or missing variables deleted']) ;
mdata = mdata(~flagdel,:) ;
varnamecellstr = varnamecellstr(~flagdel) ;


%  Create icolor & markerstr
%
icolor = [] ;
markerstr = [] ;
for i = 1:n ;
  if vresp(i) == 0 ;
    icolor = [icolor; [0 0 1]] ;
    markerstr = strvcat(markerstr,'o') ;
  elseif vresp(i) == 1 ;
    icolor = [icolor; [1 0 0]] ;
    markerstr = strvcat(markerstr,'+') ;
  else ;
      disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') ;
      disp('!!!    Error: Unexpected Response   !!!') ; 
      disp(['!!!        i = ' num2str(i)]) ; 
      disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!') ;
  end ;
end ;


%  Set graphics
%
figure(1) ;
clf ;
d = size(mdata,1) ;
n = size(mdata,2) ;


%  Setup analysis parameters
isubpopkde = 1 ;
istat = 2 ;
    %  Sample SD
viplot = [] ;
    %  default equally spaced points


%  Do MargDistPlot
paramstruct = struct('istat',istat, ...
                     'varnamecellstr',{varnamecellstr}, ...
                     'nplot',9, ...
                     'viplot',viplot, ...
                     'icolor',icolor, ...
                     'markerstr',markerstr, ...
                     'isubpopkde',isubpopkde) ;
MargDistPlotSM(mdata,paramstruct) ;


%  Create png file
%
  orient portrait ;
  set(gcf,'PaperSize',[12.0, 10.0]) ; 
  set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 9.5]) ; 
print('-dpng','OODAfig5p8.png') ;



