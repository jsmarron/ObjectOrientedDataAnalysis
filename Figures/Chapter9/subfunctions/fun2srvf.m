function [srvf] = fun2srvf(fInput,xgrid,itype);
% convert function to SRVF
% - LXS



if nargin < 3
    itype = 0;
end;

if itype==0;
    
    binsize = mean(diff(xgrid)) ;
    n = size(fInput,2);
    srvf = fInput;
    for i = 1:n;
        dev = gradient(fInput(:,i), binsize);
        % srvf(:,i) = dev./sqrt(abs(dev)+eps);
        srvf(:,i) = sqrt(abs(dev)).*sign(dev);
    end;
    
end

if itype==1;
    
    binsize = mean(diff(xgrid));
    [d,n] = size(fInput);
    srvf = zeros(d-1,n);
    for i = 1:n;
        dev = diff(fInput(:,i))/binsize;
        srvf(:,i) = sqrt(abs(dev)).*sign(dev);
    end;
    
end
