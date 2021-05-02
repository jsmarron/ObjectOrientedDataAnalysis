function [dist] = L2dist(f1Input,f2Input,xgrid);


whichValid = (isnan(f1Input)+isnan(f2Input))==0;
f1Input(~whichValid) = 0;
f2Input(~whichValid) = 0;


binsize = mean(diff(xgrid)) ;

integrand = (f1Input - f2Input).^2;
inte = trapz(xgrid,integrand);

dist = sqrt(inte);
