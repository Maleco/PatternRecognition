% Each column is a point
points = [
    0.5 1.0 0.0;
    0.31 1.51 -0.50;
    -1.7 -1.7 -1.7
    ];

h = 1;
for point = 1:3
    cat1 = 0;cat2 = 0;cat3 = 0;
    for x = 1:10
        cat1 = cat1 + phi(points(point,:), x_w1(x,:), h);
        cat2 = cat2 + phi(points(point,:), x_w2(x,:), h);
        cat3 = cat3 + phi(points(point,:), x_w3(x,:), h);
    end
    
    % Divide the result by a normalization factor (h 2π) 3 which essentially is the volume
    % of the Parzen window.
    cat1 = cat1 / (h*sqrt(2*pi))^3;
    cat2 = cat2 / (h*sqrt(2*pi))^3;
    cat3 = cat3 / (h*sqrt(2*pi))^3;
    % Divide the result by the number of data points in the concerned category (10).
    cat1 = cat1 / length(x_w1);
    cat2 = cat2 / length(x_w2);
    cat3 = cat3 / length(x_w3);
    
    X = ['For point ',num2str(point),' the prob densities are: ',num2str(cat1),' ',num2str(cat2),' ',num2str(cat3)];
    disp(X)

    
    % Compute the posterior probabilities of the categories for that every point.
    X = ['For point ',num2str(point),' the post probabilities are: ',num2str(cat1/3),' ',num2str(cat2/3),' ',num2str(cat3/3)];
    disp(X)
    
end

