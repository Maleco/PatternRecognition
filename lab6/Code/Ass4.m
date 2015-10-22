close all;
load('exercise4_data.mat', 'data');

% Calculate the z-score for every data point
zdata = zscore(data);

% Compute the dissimilarity matrices for all the features combined and
% separately
D = squareform(pdist(zdata));
D1 = squareform(pdist(zdata(:,1)));
D2 = squareform(pdist(zdata(:,2)));
D3 = squareform(pdist(zdata(:,3)));
D4 = squareform(pdist(zdata(:,4)));
D5 = squareform(pdist(zdata(:,5)));

% writetable(table(round(D,2)),'../Report/dissMatrixAss4.csv')

% Define the labels for the dendograms
labels = {'S Holland';'N Holland';'Utrecht';'Limburg';'N Brabant';'Gelderland';'Overijssel';'Flevoland';'Groningen';'Zeeland';'Friesland';'Drenthe'};

% Plot the dendograms for all the features combined and separately
figure(1);
subplot(1,2,1); dendrogram(linkage(D, 'single'), 'Orientation','right', 'Labels', labels); 
xlabel('dissimilarity');ylabel('data points');title('All features');
subplot(1,2,2); dendrogram(linkage(D1, 'single'), 'Orientation','right', 'Labels', labels);
xlabel('dissimilarity');ylabel('data points');title('Population');
print(sprintf('../Report/Ass4a'), '-depsc');

figure(2);
subplot(1,2,1); dendrogram(linkage(D2, 'single'), 'Orientation','right', 'Labels', labels);
xlabel('dissimilarity');ylabel('data points');title('Area');
subplot(1,2,2); dendrogram(linkage(D3, 'single'), 'Orientation','right', 'Labels', labels);
xlabel('dissimilarity');ylabel('data points');title('Density');
print(sprintf('../Report/Ass4b'), '-depsc');

figure(3);
subplot(1,2,1); dendrogram(linkage(D4, 'single'), 'Orientation','right', 'Labels', labels); 
xlabel('dissimilarity');ylabel('data points');title('GDP');
subplot(1,2,2); dendrogram(linkage(D5, 'single'), 'Orientation','right', 'Labels', labels); 
xlabel('dissimilarity');ylabel('data points');title('GDP per cap');
print(sprintf('../Report/Ass4c'), '-depsc');