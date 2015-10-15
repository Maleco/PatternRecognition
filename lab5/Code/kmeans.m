function [qError] = kmeans(dat, k, writeOutput)
% K-means clustering algorithm
close all;
shapes = 'op^shx+*dv<>.';

% Init the prototypes to a random point
prototypes = zeros(k,ndims(dat));
for i = 1:k
    newPoint = dat(randi(length(dat)),1:2);
    while (sum(pdist2(prototypes, newPoint) == 0) ~= 0)
        newPoint = dat(randi(length(dat)),1:2);
    end
    prototypes(i,:) = newPoint;
end

%Init the first figure
figure(1)
hold on;
xlabel('x');
ylabel('y');

for i = 1 : size(prototypes, 1)
    plot(prototypes(i,1),prototypes(i,2),'Marker', shapes(i), 'MarkerSize', 10, 'MarkerFaceColor', 'black')
end


% Perform k-means
loop = 1;
while(loop == 1)
    loop = 0;
    
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
        plot(newMean(1),newMean(2),'Marker', shapes(prototype), 'MarkerSize', 10, 'MarkerFaceColor', 'black')
    end
    
    
end

% Calculate the quantization error
qError = 0;
for i = 1 : size(prototypes, 1)
    qError = qError + sum(pdist2(prototypes(i,:), dat(dat(:,3) == i,1:2)));
end

% More figure stuff
legend(strtrim(cellstr(num2str((1:k)'))'));
if writeOutput == 1
    print(sprintf('../Report/Fig1_k%d', k), '-depsc');
end
figure(2)
hold on;
gscatter(dat(:,1),dat(:,2),dat(:,3),[],shapes, 5)


for i = 1 : size(prototypes, 1)
    plot(prototypes(i,1),prototypes(i,2),'Marker', shapes(i), 'MarkerSize', 13, 'MarkerFaceColor', 'black')
end

xlabel('x');
ylabel('y');
if writeOutput == 1
    print(sprintf('../Report/Fig2_k%d', k), '-depsc');
end
