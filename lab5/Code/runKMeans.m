load('kmeans1.mat', 'kmeans1');

error= zeros(1,10);
kmax = 2;
J = zeros(1, kmax);
R = zeros(1,kmax);

for k = 1 : kmax
    for i = 1:10
       error(i) = kmeans(kmeans1, 100, 1, 0);
    end
    J(k) = mean(error);
    R(k) = J(k) * k^(-2/ndims(kmeans1));
end

D = R./J;

figure(3)
plot(D);

% Perform the kmeans++ test
k = 100;
nRuns = 20;
error_without = zeros(1,nRuns);
error_with    = zeros(1,nRuns);
for i = 1:nRuns
    datestr(now)
    i
    error_without(i) = kmeans(checkerboard, k, 0, 0);
    error_with(i)    = kmeans(checkerboard, k, 1, 0);
end
error_without = error_without/nRuns;
error_with = error_with/nRuns;

mean(error_without)
std(error_without)
mean(error_with)
std(error_with)

% using an unpaired one-tailed two-sample t-test
ttest2(error_without, error_with)