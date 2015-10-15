load('kmeans1.mat', 'kmeans1');
error= zeros(1,10);
kmax = 2;
J = zeros(1, kmax);
R = zeros(1,kmax);

for k = 1 : kmax
    for i = 1:10
       error(i) = kmeans(kmeans1,k);
    end
    J(k) = mean(error);
    R(k) = J(k) * k^(-2/ndims(kmeans1));
end

D = R./J;

figure(3)
plot(D);