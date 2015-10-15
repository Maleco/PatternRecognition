load('kmeans1.mat', 'kmeans1');

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
       error(i) = kmeans(kmeans1,k, 0);
    end
    J(k) = mean(error);
    R(k) = J(k) * k^(-2/ndims(kmeans1));
end

D = R ./ J;

% Plot D
figure(3)
plot(D);
xlabel('k');
ylabel('D');
print(sprintf('../Report/Fig3'), '-depsc');

% Plot J and R
figure (4)
hold on ;
plot(J);
plot(R, '--');
xlabel('k');
ylabel('Mean error');
legend('J', 'R');

print(sprintf('../Report/Fig4'), '-depsc');