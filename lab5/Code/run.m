load('kmeans1.mat', 'kmeans1');
load('checkerboard.mat', 'checkerboard')

error= zeros(1,10);
kmax = 20;
J = zeros(1, kmax);
R = zeros(1,kmax);

% Run for 1 to kmax clusters
for k = 1 : kmax
    k
    % Run it 10 times for every cluster and calculate the mean error and
    % reference
    for i = 1:10
       error(i) = kmeans(kmeans1, 2, 1, 0);
    end
    J(k) = mean(error)/10;
    R(k) = J(1) * k^(-2/ndims(kmeans1));
end

D = R ./ J;

% Plot D
[maxVal maxInd] = max(D);
figure(3)
hold on;
plot(D);

plot(maxInd, maxVal,'Marker', '^', 'MarkerSize', 6, 'MarkerFaceColor', 'black')
xlabel('k');
ylabel('D');
print(sprintf('../Report/Fig3'), '-depsc');

% Plot J and R
figure (4)
hold on ;
plot(J);
plot(R, '--');
plot(maxInd, J(maxInd),'Marker', '^', 'MarkerSize', 10, 'MarkerFaceColor', 'black')
plot(maxInd, R(maxInd),'Marker', '^', 'MarkerSize', 10, 'MarkerFaceColor', 'black')
xlabel('k');
ylabel('Mean error');
legend('J', 'R');
print(sprintf('../Report/Fig4'), '-depsc');

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

% With should give a smaller average, Without larger ->
% Tail right = x larger than y
% The variances are unequal
[h, p] = ttest2(error_without, error_with, 'Tail', 'right','Vartype','unequal');
p

% Compare batch Neural Gas with our kmeans
batchNG(checkerboard,100,500)
kmeans(checkerboard,100,2,1)

