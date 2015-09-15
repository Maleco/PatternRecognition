hold off;
hist(hd,30); xlabel('Hamming distance'), ylabel('Count'); legend('hd_s', 'hd_d');
hold on;
x= sum(hd_d(:)==mode(hd_d))
normd = normpdf([0:0.01:1],mean(hd_d),std(hd_d));
plot([0:0.01:1],normd)