% Generate a two-dimensional Gaussian pdf with a mean [3 4] and covariance matrix  
% 1 0
% 0 2
mean = [3 4]
cov = [1 0; 0 2]
dist = gmdistribution(mean,cov)
mesh(dist)
inputmatrix = [0 0];
output;
counter = 1;
for i = -10:10
    for j = -10:10
        inputmatrix(counter,:) = [i j];
        
        counter = counter + 1;
    end
end
% 1. Plot this function on [-10 10] × [-10 10] usin;
output = reshape(pdf(dist, inputmatrix),[21,21])
mesh(-10:10,-10:10,output)g the mesh function.

% 2. Compute the Mahalanobis distance between the points [10 10]’, [0 0]’, [3 4]’, [6 8]’ and
% the mean of this density function.
% For observation I, the Mahalanobis distance is defined by d(I) = (Y(I,:)-mu)*inv(SIGMA)*(Y(I,:)-mu)'
% So for [10 10]:
([10 10]-mean)*inv(cov)*([10 10]-mean).'
([0   0]-mean)*inv(cov)*([0   0]-mean).'
([3   4]-mean)*inv(cov)*([3   4]-mean).'
([6   8]-mean)*inv(cov)*([6   8]-mean).'