figure;
plot(matA(:,1),matA(:,2), 'bp', 'markersize', 2);
hold on;
plot(matB(:,1),matB(:,2), 'rp', 'markersize', 2);
xlabel('x'); ylabel('y');
legend('Set A', 'Set B');

w_A = 2;
w_B = 1;
eta = 0.01;
nrEpochs = 200;
E_1 = zeros(1,nrEpochs);
E_2 = zeros(1,nrEpochs);
w = zeros(w_A + w_B, 3);

classA = matA;
classB = matB;


% Randomly initialize the prototypes between the minimum and maximum values
for i = 1 : size(w,1)
    if i <= w_A
        w(i, 1)  = 1;
        for j = 1 : ndims(classA);
            w(i, j+1) = mean(classA(:,j)) + rand()*2*std(classA(:,j))-std(classA(:,j));
        end
    else
        w(i, 1) = 2;
        for j = 1 : ndims(classB);
            w(i, j+1) = mean(classB(:,j)) + rand()*2*std(classB(:,j))-std(classB(:,j));
        end
    end
end

plot(w(1:w_A,2), w(1:w_A,3), 'b+', 'markersize', 15);
plot(w(w_A+1:size(w,1),2), w(w_A+1:size(w,1),3), 'r+', 'markersize', 15);

for epoch = 1:nrEpochs
    % Loop through class A
    for i = 1 : size(classA, 1)
        % minEuc = sqrt(max(classA(:,2))^2 + max(classA(:,3))^2);
        pdist2(classA(i,:), w(:,2:3));
        % Find the row with the nearest prototype
        rowMin = find(pdist2(classA(i,:), w(:,2:3)) == min(pdist2(classA(i,:), w(:,2:3))),1);
        % If the classes of the data point and the nearest prototype are the same
        if w(rowMin,1) == 1
            % Move the row closer to the data point
            w(rowMin,2:3) = w(rowMin,2:3) + eta * (classA(i,:) - w(rowMin,2:3));
        else w(rowMin,2:3) = w(rowMin,2:3) - eta * (classA(i,:) - w(rowMin,2:3));
        end
    end
    
    % Now for class B
    for i = 1 : size(classB, 1)
        % minEuc = sqrt(max(classA(:,2))^2 + max(classA(:,3))^2);
        pdist2(classB(i,:), w(:,2:3));
        % Find the row with the nearest prototype
        rowMin = find(pdist2(classB(i,:), w(:,2:3)) == min(pdist2(classB(i,:), w(:,2:3))),1);
        % If the classes of the data point and the nearest prototype are the same
        if w(rowMin,1) == 2
            % Move the row closer to the data point
            w(rowMin,2:3) = w(rowMin,2:3) + eta * (classB(i,:) - w(rowMin,2:3));
        else w(rowMin,2:3) = w(rowMin,2:3) - eta * (classB(i,:) - w(rowMin,2:3));
        end
    end
    
    % Now calc the error
    % Loop through class A
    for i = 1 : size(classA, 1)
        % minEuc = sqrt(max(classA(:,2))^2 + max(classA(:,3))^2);
        pdist2(classA(i,:), w(:,2:3));
        % Find the row with the nearest prototype
        rowMin = find(pdist2(classA(i,:), w(:,2:3)) == min(pdist2(classA(i,:), w(:,2:3))),1);
        % If the classes of the data point and the nearest prototype are the same
        if w(rowMin,1) ~= 1
           E_1(epoch) = E_1(epoch) + 1;
        end
    end
    
    % Now for class B
    for i = 1 : size(classB, 1)
        % minEuc = sqrt(max(classA(:,2))^2 + max(classA(:,3))^2);
        pdist2(classB(i,:), w(:,2:3));
        % Find the row with the nearest prototype
        rowMin = find(pdist2(classB(i,:), w(:,2:3)) == min(pdist2(classB(i,:), w(:,2:3))),1);
        % If the classes of the data point and the nearest prototype are the same
        if w(rowMin,1) ~= 2
            E_2(epoch) = E_2(epoch) + 1;
        end
    end
    
end

plot(w(1:w_A,2), w(1:w_A,3), 'bp', 'markersize', 15);
plot(w(w_A+1:size(w,1),2), w(w_A+1:size(w,1),3), 'rp', 'markersize', 15);

figure;
plot(E_1/200)
xlabel('Epochs')
ylabel('Error rate')
hold on;
plot(E_2/200);
legend('Error Class 1', 'Error Class 2');