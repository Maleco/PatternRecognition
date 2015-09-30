clear all;
load lab3_2.mat;

K=1;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

%Determine the optimal choice of the parameter K in the range 1, 3, . . . , 25 using leave-
%one-out cross validation:
error = zeros (25, 1);
for K = 1:2:25
    for i = 1:length(data)
        point = data(i,:);
        % For each point in the data set, make a copy of the dataset without that point.
        temp_data = data; 
        temp_class_labels = class_labels;
        temp_data(i,:) = [];
        temp_class_labels(i) = [];
        
        % Classify the point using the reduced dataset.  
        if class_labels(i) ~= KNN(point, K, temp_data, temp_class_labels)
            error(K) = error(K) + 1;
        end
    end 
end

% Plot the resulting errors
bar(1:2:25, error(1:2:25)/200)
xlabel('K-value')
ylabel('Error rate (Number of errors/Total number of data points)')
