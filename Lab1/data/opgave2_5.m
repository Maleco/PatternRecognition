% Calculate the cumulative distribution function for the given x-value
% (range 0.000 - 1.000, with stepsize 0.001)
normc = normcdf([0:0.001:1],mean(hd_d),std(hd_d));
% Count the amount of x-values below the threshold value, minus 1 to
% correct from starting from 0.000, and divide by 1000 to get a nice 
% chance number
d = (sum(normc(:) <= 0.0005)-1)/1000;d

% Same as before, now for set S
normc = normcdf([0:0.001:1],mean(hd_s),std(hd_s));
% False rejection is integral of HD > d = 1 - normc(d)
1 - normc((d*1000)+1)