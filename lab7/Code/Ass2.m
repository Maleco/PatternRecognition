close all;
load('mixedsignals.mat', 'smix');

X = smix;
% Number of weight vectors
numWeight = 4;
numplots = size(X, 1) + numWeight;

% Initialize the weight vector
w = rand(size(X, 1),numWeight);

threshold = 0.0001;
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


% Calculate the estimated independent  component
y1 = w.'*X;

% Plot the spearate signals and the estimated independent component in one
% figure
figure();
hold on;
subplot(numplots,1,1);
plot(smix(1,:));
xlabel('x');ylabel('y');
title('Signal 1');

subplot(numplots,1,2);
plot(smix(2,:));
xlabel('x');ylabel('y');
title('Signal 2');

subplot(numplots,1,3);
plot(smix(3,:));
xlabel('x');ylabel('y');
title('Signal 3');

subplot(numplots,1,4);
plot(smix(4,:));
xlabel('x');ylabel('y');
title('Signal 4');

for i = 5:numplots
    subplot(numplots,1,i);
    plot(y1(i-4,:), 'lineWidth', 2);
    xlabel('x');ylabel('y');
    title(['Estimated independent component ' num2str(i-4)]);
end

print(sprintf('../Report/Ass3'), '-depsc');