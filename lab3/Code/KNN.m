function [class] = KNN( X, K, data, class_labels)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Calculate distance to each point ([distance class])
distances = zeros(length(data), ndims(data));
for row = 1:length(data)
    dist = 0;
    for dim = 1:ndims(data)
        dist = dist + abs(data(row,dim)-X(1,dim));
    end
    distances(row,:) = [dist class_labels(row)];
end
distances = sortrows(distances);

class = mode(distances(1:K,2));
end

