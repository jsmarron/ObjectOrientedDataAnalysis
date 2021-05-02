function [rs] = logD(fInput,xgrid);
% log derivative


binsize = mean(diff(xgrid)) ;
n = size(fInput,2);
rs = zeros(size(fInput));
for i = 1:n;
    dev = gradient(fInput(:,i), binsize);
    rs(:,i) = log(abs(dev)).*sign(dev);
end;

% plot(dev)
% plot(rs(:,i))

% dev(log(f))

% binsize = mean(diff(xgrid)) ;
% n = size(fInput,2);
% rs = fInput;
% for i = 1:n;
%     rs(:,i) = gradient(log(fInput(:,i)), binsize);
% end;