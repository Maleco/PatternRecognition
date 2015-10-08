load('data_lvq_A') % matA
load('data_lvq_B') % matB

K = 10;

%10 FOLD Cross validation
data = [matA ; matB];
data_labels = (floor( (0:length(data)-1) * 2 / length(data))).';
data = [data data_labels];
indices = 1:length(data)/K:length(data)+(length(data)/K);
E_K = zeros(1,K);

for fold = 1:K
    train_data = data;
    train_data(indices(fold):indices(fold+1)-1,:) = [];
    test_data  = data(indices(fold):indices(fold+1)-1,:);
    
    % The prototypes
    w_A = 2;
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
    
    for epoch = 1:nrEpochs
        % Training
        for point = 1 : size(train_data,1)
            % Find the row with the nearest prototype
            rowMin = find(pdist2(train_data(point,1:2), w(:,1:2)) == min(pdist2(train_data(point,1:2), w(:,1:2))),1);
            % If the classes of the train_data point and the nearest prototype are the same
            if w(rowMin,end) == train_data(point, end)
                % Move the row closer to the train_data point
                w(rowMin,1:2) = w(rowMin,1:2) + eta * (train_data(point,1:2) - w(rowMin,1:2));
            else
                w(rowMin,1:2) = w(rowMin,1:2) - eta * (train_data(point,1:2) - w(rowMin,1:2));
            end
        end
        
        % Testing
        for point = 1 : size(train_data,1)
            % Find the row with the nearest prototype
            rowMin = find(pdist2(train_data(point,1:2), w(:,1:2)) == min(pdist2(train_data(point,1:2), w(:,1:2))),1);
            if w(rowMin,end) ~= train_data(point, end)
                if point <= size(matA,1)
                    E_1(epoch) = E_1(epoch) + 1;
                else
                    E_2(epoch) = E_2(epoch) + 1;
                end
            end
        end
        E = E_1 + E_2;
        
        if (epoch > 10 && var(E(:,epoch-4:epoch)) < 0.05)
            fold
            E_1(:,epoch+1:end) = [];
            E_2(:,epoch+1:end) = [];
            E(:,epoch+1:end) = [];
            break
        end
    end
    
    % Now test on the test set
    % Testing
    for point = 1 : size(test_data,1)
        % Find the row with the nearest prototype
        rowMin = find(pdist2(test_data(point,1:2), w(:,1:2)) == min(pdist2(test_data(point,1:2), w(:,1:2))),1);
        if w(rowMin,end) ~= test_data(point, end)
            E_K(fold) = E_K(fold) + 1;
        end
    end
end

% The mean error rate over the 10 folds
mean(E_K/size(test_data,1))
    