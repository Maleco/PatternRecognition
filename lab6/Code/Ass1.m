close all;
load('cluster_data.mat', 'cluster_data');
dat = cluster_data;
k = size(dat, 2);
% Calculate the minkowski distances between the points for k dimensions
dist = pdist2(dat, dat, 'minkowski', k);

% Make a new figure for every t-value and plot the relevant connections
for t = 0.00 : 0.05 : 0.25
    figure;
    hold on;
    plot(dat(:,1), dat(:,2), 'o');
    % Loop over all points and plot the connections when the distance
    % between two points is smaller than t
    for point = 1 : length(dat)
        for point2 = point+1 : length(dat)
            if dist(point, point2) < t
                plot([dat(point,1) dat(point2,1)], [dat(point,2) dat(point2,2)])
            end
        end
    end
    xlabel('x'); ylabel('y'); title(['t = ' num2str(t)]);
    print(sprintf(['../Report/Ass1_' num2str(t*100)]), '-depsc');
    hold off;
end