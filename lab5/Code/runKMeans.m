load('kmeans1.mat', 'kmeans1');
meanError = zeros(1,10);
k = 2;
for k = [2 3 4]
    meanError(k) = kmeans(kmeans1,k,0);
end
mean(meanError)

