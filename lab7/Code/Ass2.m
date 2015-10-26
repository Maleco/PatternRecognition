close all; 
load('mixedsignals.mat', 'smix');
X = smix;

% Initialize the weight vector
w = rand(size(X, 1),1);

threshold = 0.0001;
convergence = 0;

% As long as w is not converged to 1 +- threshold update it according to
% the update mechanism deined in the assignment
while convergence < 1 - threshold || convergence > 1 + threshold
    g = tanh(X.' * w);
    g_accent = 1 - g.^2;
    w_plus = X * g / size(X, 1) - sum(g_accent)/size(X, 1) * w;
    w_plus = w_plus / norm(w_plus);
    convergence = dot(w, w_plus)
    w = w_plus;
end

% Calculate the estimated independent  component
y1 = w.'*X;

% Plot the spearate signals and the estimated independent component in one
% figure
figure();
hold on;
subplot(5,1,1);
plot(smix(1,:));
xlabel('x');ylabel('y');
title('Signal 1');

subplot(5,1,2);
plot(smix(2,:));
xlabel('x');ylabel('y');
title('Signal 2');

subplot(5,1,3);
plot(smix(3,:));
xlabel('x');ylabel('y');
title('Signal 3');

subplot(5,1,4);
plot(smix(4,:));
xlabel('x');ylabel('y');
title('Signal 4');

subplot(5,1,5);
plot(y1, 'lineWidth', 2);
xlabel('x');ylabel('y');
title('Estimated independent component');

print(sprintf('../Report/Ass2'), '-depsc');
