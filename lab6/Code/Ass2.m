
X = cluster_data;
c_min = cluster(linkage(squareform(pdist(cluster_data)), 'single'), 'maxclust', 4);
c_max = cluster(linkage(squareform(pdist(cluster_data)), 'complete'), 'maxclust', 4);
c_avg = cluster(linkage(squareform(pdist(cluster_data)), 'average'), 'maxclust', 4);
c_mean = cluster(linkage(squareform(pdist(cluster_data)), 'centroid'), 'maxclust', 4);

hold on;
figure();
subplot(2,2,1)
scatter(X(:,1),X(:,2),[],c_min, 'filled');
hold on;
for group = 1:4
    plot(mean(X(c_min == group,1)),mean(X(c_min == group,2)), 'o', 'MarkerSize', 15, 'MarkerFacecolor', 'b');
end
xlabel('x');ylabel('y');title('Min');
subplot(2,2,2   )
scatter(X(:,1),X(:,2),[],c_max, 'filled')
hold on;
for group = 1:4
    plot(mean(X(c_min == group,1)),mean(X(c_min == group,2)), 'o', 'MarkerSize', 15, 'MarkerFacecolor', 'b');
end
xlabel('x');ylabel('y');title('Max');
subplot(2,2,3)
scatter(X(:,1),X(:,2),[],c_avg, 'filled')
hold on;
for group = 1:4
    plot(mean(X(c_min == group,1)),mean(X(c_min == group,2)), 'o', 'MarkerSize', 15, 'MarkerFacecolor', 'b');
end
xlabel('x');ylabel('y');title('Average');
subplot(2,2,4)
scatter(X(:,1),X(:,2),[],c_mean, 'filled')
hold on;
for group = 1:4
    plot(mean(X(c_min == group,1)),mean(X(c_min == group,2)), 'o', 'MarkerSize', 15, 'MarkerFacecolor', 'b');
end
xlabel('x');ylabel('y');title('Mean');
print(sprintf('../Report/Ass2_1'), '-depsc');
 
figure();
subplot(2,2,1); dendrogram(linkage(squareform(pdist(cluster_data)), 'single'), 270); 
xlabel('data points');ylabel('distance');title('Min');
subplot(2,2,2); dendrogram(linkage(squareform(pdist(cluster_data)), 'complete'), 270);
xlabel('data points');ylabel('distance');title('Max');
subplot(2,2,3); dendrogram(linkage(squareform(pdist(cluster_data)), 'average'), 270);
xlabel('data points');ylabel('distance');title('Average');
subplot(2,2,4); dendrogram(linkage(squareform(pdist(cluster_data)), 'centroid'), 270);
xlabel('data points');ylabel('distance');title('Mean');
print(sprintf('../Report/Ass2_2'), '-depsc');