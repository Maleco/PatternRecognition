load('kmeans1.mat', 'kmeans1');
meanError = zeros(1,10);
k = 4;
for i = 1:10
    meanError(i) = kmeans(kmeans1,k);
end
mean(meanError)

