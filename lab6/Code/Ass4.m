close all;
load('exercise4_data.mat', 'data');

% Calculate the z-score for every data point
zdata = zscore(data);

% Compute the dissimilarity matrix
D = squareform(pdist(zdata));
writetable(table(round(D,2)),'../Report/dissMatrixAss4.csv')

labels = ['S Holland' 'N Holland' ];

figure();
subplot(2,2,1); dendrogram(linkage(D, 'single'), 'Orientation','right', 'Labels', ); 
xlabel('data points');ylabel('distance');title('Min');
subplot(2,2,2); dendrogram(linkage(D, 'complete'), 'Orientation','right', 'Labels');
xlabel('data points');ylabel('distance');title('Max');
subplot(2,2,3); dendrogram(linkage(D, 'average'), 'Orientation','right', 'Labels');
xlabel('data points');ylabel('distance');title('Average');
subplot(2,2,4); dendrogram(linkage(D, 'centroid'), 'Orientation','right', 'Labels');
xlabel('data points');ylabel('distance');title('Mean');

print(sprintf('../Report/Ass4'), '-depsc');