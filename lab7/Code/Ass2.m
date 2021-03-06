close all;
load('mixedsignals.mat', 'smix');

% Sphere the signals
centeredS = bsxfun(@minus, smix.', sum(smix.')/size(smix.', 1)); 
[eigVectors, eigValues] = eig(cov(centeredS));
X = eigVectors * (eigValues^-.5) * eigVectors.' * smix;

% Number of weight vectors
numWeight = 500;

% Initialize the weight vector
w = rand(size(X, 1),numWeight);

threshold = 0.0000000001;
convergence = 0;

% As long as w is not converged to 1 +- threshold update it according to
% the update mechanism deined in the assignment
for n = 1:numWeight
    % Calculate a component
    while convergence < 1 - threshold || convergence > 1 + threshold
        g = tanh(X.' * w(:,n));
        g_accent = 1 - g.^2;
        w_plus = X * g / size(X, 1) - sum(g_accent)/size(X, 1) * w(:,n);
        w_plus = w_plus / norm(w_plus);
        convergence = dot(w(:,n), w_plus);
        w(:,n) = w_plus;
    end
    
    % Decorrelate the next component
    if n < numWeight
        sumVector = zeros(size(X, 1),1);
        for i = 1:n
            sumVector = sumVector + w(:,n+1).' * w(:,i) * w(:,i);
        end
        w(:,n+1) = w(:,n+1) - sumVector;
        w(:,n+1) = w(:,n+1)  / sqrt(w(:,n+1).' * w(:,n+1));
    end
end

% Rounded to 4 decimals to prevent -0.0000 in Matlab
w = unique(round(w.', 4), 'rows', 'stable').';
numplots = size(w, 2);

% Calculate the estimated independent  component
y1 = w.'*X;

% Plot the spearate signals and the estimated independent component in one

figure();
hold on;
subplot(size(X, 1),1,1);
plot(spheredS(1,:));
xlabel('Measurements');ylabel('Value');
title('Signal 1');

subplot(size(X, 1),1,2);
plot(spheredS(2,:));
xlabel('Measurements');ylabel('Value');
title('Signal 2');

subplot(size(X, 1),1,3);
plot(spheredS(3,:));
xlabel('Measurements');ylabel('Value');
title('Signal 3');

subplot(size(X, 1),1,4);
plot(spheredS(4,:));
xlabel('Measurements');ylabel('Value');
title('Signal 4');

print(sprintf('../Report/Ass3a'), '-depsc');

figure();
for i = 1:numplots
    subplot(numplots,1,i);
    plot(y1(i,:), 'lineWidth', 2);
    xlabel('x');ylabel('Value');
    title(['Estimated independent component ' num2str(i)]);
end

print(sprintf('../Report/Ass3_all'), '-depsc');

% Plot the histograms
figure();
hold on;
subplot(size(smix, 1),1,1);
hist(spheredS(1,:));
xlabel('Measurements');ylabel('Count');
title('Signal 1');

subplot(size(smix, 1),1,2);
hist(spheredS(2,:));
xlabel('Measurements');ylabel('Count');
title('Signal 2');

subplot(size(smix, 1),1,3);
hist(spheredS(3,:));
xlabel('Measurements');ylabel('Count');
title('Signal 3');

subplot(size(smix, 1),1,4);
hist(spheredS(4,:));
xlabel('Measurements');ylabel('Count');
title('Signal 4');

print(sprintf('../Report/Ass3_hist1'), '-depsc');

figure();
for i = 1:numplots
    subplot(numplots,1,i);
    hist(y1(i,:));
    xlabel('Measurements');ylabel('Count');
    title(['Estimated independent component ' num2str(i)]);
end

print(sprintf('../Report/Ass3_hist2'), '-depsc');