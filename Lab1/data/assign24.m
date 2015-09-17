hold off;

% Making the histogram
hd = [hd_s;hd_d].'
hist(hd,30); xlabel('Hamming distance'), ylabel('Count');
hold on;

% Create scaled Gaussian plots
x2 = sum(hd_s(:) == mode(hd_s));
normd = normpdf([0:0.01:1],mean(hd_s),std(hd_s));
plot([0:0.01:1],normd*(x2/max(normd)));

x1 = sum(hd_d(:) == mode(hd_d));
normd = normpdf([0:0.01:1],mean(hd_d),std(hd_d));
plot([0:0.01:1],normd*(x1/max(normd)));

legend('hd_s', 'hd_d', 'hd_s normd', 'hd_d normd');