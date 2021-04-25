disp('Running MATLAB script file OODAfig11p8.m') ;
%
%    Makes Figure 11.8 of the OODA book,
%    Four Cluster 2-d Toy Data
%    Illustrates kernel PCA
%
%    Copied from OODAbookChpJFigKkernelPCA.m
%    in:        OODAbook\ChapterJ
%
%    Uses lines provided by Bernhard Scho"lkopf
%
 
ipart = 1 ;    %  0 - generate and save data
               %  1 - make main graphic

datafilestr = '..\..\DataSets\FourClusterData' ;

nc1 = 60 ;
nc2 = 30 ;
nc3 = 30 ;


if ipart == 0 ;    %  Generate and save data

  %  Set parameters
  %
  mu1 = [0.25; 0.5] ;
  mu2 = [0.65; 0.4] ;
  mu3 = [0.8; 0.3] ;
  sig1 = [[0.005 0.0095]; [0.0095 0.02]] ;
  sig1ri = sqrtm(sig1) ;
  sig2 = 0.02 ;
  sig3 = 0.02 ;
  x1 = [0.8; 0.8] ;
  x2 = [0.83; 0.78] ;

  %  Generate Data
  %
  rng(90275908)  ;
  mdata1 = mu1 * ones(1,nc1) + sig1ri * randn(2,nc1) ;
  mdata2 = mu2 * ones(1,nc2) + sig2 * randn(2,nc2) ;
  mdata3 = mu3 * ones(1,nc3) + sig3 * randn(2,nc3) ;

  mdata = [mdata1 mdata2 mdata3 x1 x2] ;


  xlswrite([datafilestr '.xlsx'],mdata) ;


else ;    %  Make main graphic

  %  Read in data
  %
  mdata = xlsread(datafilestr) ;


  %  Make main graphic
  %
  figure(1) ;
  clf ;

  n = size(mdata,2) ;

  mcolor = ones(nc1,1) * [0 1 0] ;
  mcolor = [mcolor; (ones(nc2,1) * [0 0 1])] ;
  mcolor = [mcolor; (ones(nc3,1) * [0 1 1])] ;
  mcolor = [mcolor; [1; 1] * [1 0 0]] ;

  markerstr = [] ;
  for i = 1:nc1 ;
    markerstr = strvcat(markerstr,'+') ;
  end ;
  for i = 1:nc2 ;
    markerstr = strvcat(markerstr,'o') ;
  end ;
  for i = 1:nc3 ;
    markerstr = strvcat(markerstr,'s') ;
  end ;
  markerstr = strvcat(markerstr,'x') ;
  markerstr = strvcat(markerstr,'x') ;

  left = 0 ;
  right = 1 ;
  bottom = 0; 
  top = 1 ;


  ndat = n ;
      %  since this gets redefined later

  %  My modification of Bernhard's lines
  %  
  % parameters
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  rbf_var = 0.05 ;
  ptext = 'Good' ;
  xnum = 3 ;
  ynum = 2;
  max_ev = xnum*ynum;
  % (extract features from the first <max_ev> Eigenvectors)
  %x_test_num = 15;
  x_test_num = 100 ;
  %y_test_num = 15;
  y_test_num = 100 ;
  %cluster_pos = [-0.5 -0.2; 0 0.6; 0.5 0];
  %cluster_size = 30;

  % generate a toy data set
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %num_clusters = size(cluster_pos,1);
  %train_num = num_clusters*cluster_size;
  %patterns = zeros(train_num, 2);
  %range = 1;
  %randn('seed', 0);
  %for i=1:num_clusters,
  %  patterns((i-1)*cluster_size+1:i*cluster_size,1) = cluster_pos(i,1)+0.1*randn(cluster_size,1);
  %  patterns((i-1)*cluster_size+1:i*cluster_size,2) = cluster_pos(i,2)+0.1*randn(cluster_size,1);
  %end
  patterns = mdata' ;
  test_num = x_test_num*y_test_num;
  %x_range = -range:(2*range/(x_test_num - 1)):range;
  x_range = linspace(left,right,x_test_num) ;
  %y_offset = 0.5;
  %y_range = -range+ y_offset:(2*range/(y_test_num - 1)):range+ y_offset;
  y_range = linspace(bottom,top,y_test_num) ;
  [xs, ys] = meshgrid(x_range, y_range);
  test_patterns(:, 1) = xs(:);
  test_patterns(:, 2) = ys(:);
  %cov_size = train_num;  % use all patterns to compute the covariance matrix
  cov_size = size(mdata,2) ;
  train_num = cov_size ;

  % carry out Kernel PCA
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for i=1:cov_size,
    for j=i:cov_size,
      K(i,j) = exp(-norm(patterns(i,:)-patterns(j,:))^2/rbf_var);
      K(j,i) = K(i,j);
    end
  end
  unit = ones(cov_size, cov_size)/cov_size;
  % centering in feature space!
  K_n = K - unit*K - K*unit + unit*K*unit;

  [evecs,evals] = eig(K_n);
  evals = real(diag(evals));
  for i=1:cov_size,
    evecs(:,i) = evecs(:,i)/(sqrt(evals(i)));
  end

  unit_test = ones(test_num,cov_size)/cov_size;
  K_test = zeros(test_num,cov_size);
  for i=1:test_num,
    for j=1:cov_size,
      K_test(i,j) = exp(-norm(test_patterns(i,:)-patterns(j,:))^2/rbf_var);
    end
  end
  K_test_n = K_test - unit_test*K - K_test*unit + unit_test*K*unit;
  test_features = zeros(test_num, max_ev);
  test_features = K_test_n * evecs(:,1:max_ev);


  for ipanel = 1:3 ;

    subplot(1,3,ipanel) ;

    axis([left right bottom top]) ;
    imag = reshape(test_features(:,ipanel), y_test_num, x_test_num);
    colormap(gray);
    hold on;
  %  pcolor(x_range, y_range, imag);
  %  shading interp

    vimag = reshape(imag,size(imag,1) * size(imag,2),1) ;
    colorcut = cquantSM(abs(vimag),0.95) ;

    imag = imag / colorcut ;
          %  rescale so colorcut maps to [-1,1]
    imag = 32 + 32 * imag ;
          %  rescale to [0,64]
    image(x_range,y_range,imag) ;
      axis image ;
    contour(x_range, y_range, imag, 9, 'b');
    for i = 1:ndat ;
      plot(mdata(1,i),mdata(2,i),markerstr(i),'Color',mcolor(i,:),'MarkerSize',4) ;
    end ;
    hold off ;
    axis off ;

  end ;



  %  Create png file
  %
    orient portrait ;
    set(gcf,'PaperSize',[12.0, 4.0]) ; 
    set(gcf,'PaperPosition',[0.25, 0.25, 11.5, 3.5]) ; 
  print('-dpng','OODAfig11p8.png') ;


end ;

