clear all;
load lab3_2.mat;

K=1;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end;
end;

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
xlabel('x','FontSize', 18)
ylabel('y','FontSize', 18)
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(1:50,1),scaled_data(  1:50,2),'go');
plot(scaled_data(51:100,1),scaled_data(51:100,2),'r+');
plot(scaled_data(101:150,1),scaled_data(101:150,2),'bx');
plot(scaled_data(151:200,1),scaled_data(151:200,2),'mv');
