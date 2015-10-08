load('data_lvq_A') % matA
load('data_lvq_B') % matB

close all
subplot(1,2,1)
plot(matA(:,1),matA(:,2), 'bp', 'markersize', 2);
hold on;
plot(matB(:,1),matB(:,2), 'rp', 'markersize', 2);
xlabel('x'); ylabel('y');

data = [matA ; matB];
data_labels = (floor( (0:length(data)-1) * 2 / length(data))).';
data = [data data_labels];

% The prototypes
w_A = 1;
w_B = 1;
w = zeros(w_A + w_B, ndims(data)+1);

eta = 0.01;
nrEpochs = 500;

E_1 = zeros(1,nrEpochs);
E_2 = zeros(1,nrEpochs);

% Randomly initialize the prototypes between the minimum and maximum values
% last value being their class
for i = 1 : size(w,1)
    if i <= w_A
        w(i,:) = [mean(matA) + rand()*2*std(matA)-std(matA) 0];
    else
        w(i,:) = [mean(matB) + rand()*2*std(matB)-std(matB) 1];
    end
end

plot(w(1:w_A,1), w(1:w_A,2), 'b*', 'markersize', 12);
plot(w(w_A+1:size(w,1),1), w(w_A+1:size(w,1),2), 'r+', 'markersize', 12);

for epoch = 1:nrEpochs
    % Training
    for point = 1 : size(data,1)
         % Find the row with the nearest prototype
        rowMin = find(pdist2(data(point,1:2), w(:,1:2)) == min(pdist2(data(point,1:2), w(:,1:2))),1);
        % If the classes of the data point and the nearest prototype are the same
        if w(rowMin,end) == data(point, end)
            % Move the row closer to the data point
            w(rowMin,1:2) = w(rowMin,1:2) + eta * (data(point,1:2) - w(rowMin,1:2));
        else
            w(rowMin,1:2) = w(rowMin,1:2) - eta * (data(point,1:2) - w(rowMin,1:2));
        end
    end
       
    % Testing
    for point = 1 : size(data,1)
        % Find the row with the nearest prototype
        rowMin = find(pdist2(data(point,1:2), w(:,1:2)) == min(pdist2(data(point,1:2), w(:,1:2))),1);
        if w(rowMin,end) ~= data(point, end)
            if point <= size(matA,1)
                E_1(epoch) = E_1(epoch) + 1;
            else
                E_2(epoch) = E_2(epoch) + 1;
            end
        end
    end
    E = E_1 + E_2;
    
    if (epoch > 10 && var(E(:,epoch-4:epoch)) < 0.05)
        E_1(:,epoch+1:end) = [];
        E_2(:,epoch+1:end) = [];
        E(:,epoch+1:end) = [];
        break
    end
end

plot(w(1:w_A,1), w(1:w_A,2), 'bh', 'markersize', 12);
plot(w(w_A+1:size(w,1),1), w(w_A+1:size(w,1),2), 'rP', 'markersize', 12);
lgnd = legend('Set A', 'Set B','Protypes A (init)', 'Protypes B (init)','Protypes A (final)', 'Protypes B (final)');
set(lgnd, 'interpreter','latex', 'fontsize', 15);

subplot(1,2,2)
plot(E_1/200)
hold on;
plot(E_2/200);
plot(E/200);
legend('Training Error Class 1', 'Training Error Class 2', 'Total Training Error');
xlabel('Epochs')
ylabel('Training Error rate')
