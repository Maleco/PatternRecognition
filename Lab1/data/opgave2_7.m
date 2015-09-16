hold off;

x1 = sum(hd_d(:) == mode(hd_d));
normd = normpdf([0:0.01:1],mean(hd_d),std(hd_d));
normd=normd*(x1/max(normd));

y = normcdf(hd_d, mean(hd_d), std(hd_d));
plot(y);

covd = cov(hd_d);

%[p,plo,pup] = normcdf(hd_d,mean(hd_d),std(hd_d),cov(normd),0.00025);

%plot(erf(hd_d));

erfd = sqrt(2)*erfinv(hd_d);
plot(erfd.');

ci = paramci(hd_d, ,99.95);