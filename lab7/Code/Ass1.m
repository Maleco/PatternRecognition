load('mixedsignals.mat', 'smix');

% Plot the initial values
figure(1);
plot(smix(1,:),smix(2,:), 'b.');
xlabel('x');ylabel('y');title('Mixed signal x1 and x2 before sphering');
print(sprintf('../Report/Ass1a'), '-depsc');

figure(2);
plot(smix(3,:),smix(4,:), 'b.');
xlabel('x');ylabel('y');title('Mixed signal x3 and x4 before sphering');
print(sprintf('../Report/Ass1b'), '-depsc');

% Whitening
centeredS = bsxfun(@minus, smix.', sum(smix.')/size(smix.', 1)); 
[eigVectors, eigValues] = eig(cov(centeredS));
spheredS = eigVectors * (eigValues^-.5) * eigVectors.' * smix;

% Plot the sphered values
figure(3);
plot(spheredS(1,:),spheredS(2,:), 'b.');
xlabel('x');ylabel('y');title('Mixed signal x1 and x2 after sphering');
print(sprintf('../Report/Ass1c'), '-depsc');

figure(4);
plot(spheredS(3,:),spheredS(4,:), 'b.');
xlabel('x');ylabel('y');title('Mixed signal x3 and x4 after sphering');
print(sprintf('../Report/Ass1d'), '-depsc');