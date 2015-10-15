function [qError] = kmeans(dat, k, prototypeSelector, writeOutput)
% K-means clustering algorithm
close all;
shapes = 'op^shx+*dv<>.';

dat = checkerboard;
k = 100;
prototypeSelector = 0;
writeOutput = 0;
if prototypeSelector == 0
    % Init the prototypes to a random point
    prototypes = zeros(k,ndims(dat));
    for i = 1:k
        newPoint = dat(randi(length(dat)),1:2);
        while (sum(pdist2(prototypes, newPoint) == 0) ~= 0)
            newPoint = dat(randi(length(dat)),1:2);
        end
        prototypes(i,:) = newPoint;
    end

end
if prototypeSelector == 1
    % Init the prototypes
    prototypes = zeros(k,ndims(dat));
    newPoint = dat(randi(length(dat)),1:2);
    distances = pdist2(newPoint, dat(:,1:2));
    prototypes(1,:) = newPoint;
    
    for i = 2:k
        probabilities = distances.^2;
        % Choose a random number in the range of sum(probabilities)
        newPointIndex = find(cumsum(probabilities) > rand*sum(probabilities),1);
        newPoint = dat(newPointIndex,:);
        prototypes(i,:) = newPoint;
        
        % Calculate the new distances (select min value)
        distances = min(distances, pdist2(newPoint, dat(:,1:2)));
    end
end
if prototypeSelector == 2
    sbrace = @(x,y)(x{y});
    fromfile = @(x)(sbrace(struct2cell(load(x)),1));
    prototypes=fromfile('clusterCentroids.mat');
end

% Init the first figure
figure(1)
hold on;
xlabel('x');
ylabel('y');
for i = 1 : size(prototypes, 1)
    plot(prototypes(i,1),prototypes(i,2),'Marker', shapes(max(mod(i,size(shapes,2)),1)), 'MarkerSize', 10, 'MarkerFaceColor', 'black')
end

% Perform k-means
loopCounter = 0;
loop = 1;
while(loop == 1)
    loop = 0;
    % Uncomment to show loop counter :D
    loopCounter = loopCounter + 1
    
    for point = 1 : length(dat)
        dat(point,3) = find(pdist2(dat(point,1:2), prototypes) == min(pdist2(dat(point,1:2), prototypes)),1);
    end
    
    for prototype = 1 : size(prototypes, 1)
        newMean = mean(dat(dat(:,3) == prototype,1:2));
        if newMean ~= prototypes(prototype,:)
            loop = 1;
        end
        plot_arrow( prototypes(prototype,1),  prototypes(prototype,2), newMean(:,1), newMean(:, 2));
        prototypes(prototype,:) = newMean;
        plot(newMean(1),newMean(2),'Marker', shapes(max(mod(prototype,size(shapes,2)),1)), 'MarkerSize', 10, 'MarkerFaceColor', 'black')
    end
end

% Calculate the quantization error
qError = 0;
for i = 1 : size(prototypes, 1)
    qError = qError + sum(pdist2(prototypes(i,:), dat(dat(:,3) == i,1:2)));
end

% More figure stuff
legend(num2str(1:k))
if writeOutput == 1
    print(sprintf('../Report/Fig1_KMeans'), '-depsc');
end
figure(2)
hold on;
gscatter(dat(:,1),dat(:,2),dat(:,3),[],shapes, 5)
voronoi(prototypes(:,1),prototypes(:,2))



for i = 1 : size(prototypes, 1)
    plot(prototypes(i,1),prototypes(i,2),'Marker', shapes(max(mod(i,size(shapes,2)),1)), 'MarkerSize', 13, 'MarkerFaceColor', 'black')
end

xlabel('x');
ylabel('y');
if writeOutput == 1
    print(sprintf('../Report/Fig2_KMeans'), '-depsc');
end
