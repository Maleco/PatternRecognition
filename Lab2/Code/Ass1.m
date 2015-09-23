v1 = [4,5,6];
v2 = [6,3,9];
v3 = [8,7,3];
v4 = [7,4,8];
v5 = [4,6,5];

m1 = [v1;v2;v3;v4;v5];

mean1 = [mean(m1(:,1)); mean(m1(:,2)); mean(m1(:,3))];

cov1 = cov(m1);

mean1
cov1

mvnpdf([5;5;6], mean1, cov1)
mvnpdf([3;5;7], mean1, cov1)
mvnpdf([4;6.5;1], mean1, cov1)