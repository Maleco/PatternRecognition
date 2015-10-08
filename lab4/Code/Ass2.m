load('data_lvq_A') % matA
load('data_lvq_B') % matB

K = 10;

%10 FOLD Cross validation
data = [matA ; matB];
data_labels = (floor( (0:length(data)-1) * 2 / length(data))).';
data = [data data_labels];
indices = 1:length(data)/K:length(data)+(length(data)/K);


for fold = 1:K
  train_data = data;
  train_data(indices(fold):indices(fold+1)-1,:) = [];
  test_data  = data(indices(fold):indices(fold+1)-1,:);
   
end
